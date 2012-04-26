<cfsetting showdebugoutput="false"/>

<cfif StructKeyExists(form, "adminPassword") and Len(form.adminPassword)>
	<cfif application.generatorService.setAdminPassword(form.adminPassword)>
		<cfset session.adminPassword = form.adminPassword/>
	</cfif>
</cfif>

<cfif not StructKeyExists(session, "adminPassword")>
	<cfparam name="form.adminPassword" default=""/>

	<cfoutput>
		<form action="#cgi.script_name#" method="post">
		<table>
			<tr>
				<td>Admin Password</td>
				<td><input type="password" name="adminPassword" size="25"/>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Submit"/></td>
			</tr>
		</table>
		</form>
	</cfoutput>
	<cfexit/>
</cfif>

<cfset dsns = application.generatorService.getDSNs()/>

<cfif ArrayLen(dsns) eq 1>
	<cfset form.dataSource = dsns[1]/>
</cfif>

<cfif ArrayLen(dsns)>
	<!---/*IF RAILO*/--->
	<cfif Not IsSimpleValue(dsns[1])>
		<cfset newDSNs = []/>
		<cfloop array="#dsns#" index="dsn">
			<cfset ArrayAppend(newDSNs, dsn.getDSNName()) />
		</cfloop>
		<cfset dsns = newDSNs/>
		<cfset ArraySort(dsns, "textnocase")/>
	</cfif>
</cfif>

<cfparam name="url.template" default="query"/>
<cfparam name="url.dataSource" default=""/>

<cfparam name="form.template" default="#url.template#"/>
<cfparam name="form.dataSource" default="#url.dataSource#"/>

<cfif Len(form.dataSource) and StructKeyExists(session, "dataSource") and session.dataSource neq form.dataSource>
	<cfset StructDelete(session, "dataSource")/>
	<cfset StructDelete(session, "savePath")/>
	<cfset StructDelete(form, "savePath")/>
</cfif>

<cfif Len(form.dataSource) and not StructKeyExists(form, "savePath") and not StructKeyExists(url, "savePath")>
	<cfif StructKeyExists(session, "savePath") and Len(session.savePath)>
		<cfset form.savePath = session.savePath/>
	<cfelse>
		<cfset form.savePath = ExpandPath("temp/" & form.dataSource)/>
	</cfif>
</cfif>

<cfparam name="url.table" default=""/>
<cfparam name="url.cfcPath" default=""/>
<cfparam name="url.savePath" default=""/>
<cfparam name="url.stripPrefix" default=""/>

<cfparam name="form.table" default="#url.table#"/>
<cfparam name="form.cfcPath" default="#url.cfcPath#"/>
<cfparam name="form.savePath" default="#url.savePath#"/>
<cfparam name="form.stripPrefix" default="#url.stripPrefix#"/>

<cfif Len(form.dataSource)>
	<cfset tables = application.generatorService.getTablesQuick(form.dataSource)/>
	<cfset session.dataSource = form.dataSource/>
</cfif>
<cfset templates = application.generatorService.getProjectTemplates()/>

<cfoutput>
<form action="" method="post">
<table>
	<tr>
		<td>Template</td>
		<td>
			<select name="template" style="width:250px">
			<cfloop array="#templates#" index="template">
				<option value="#template#"<cfif form.template eq Trim(template)> selected="selected"</cfif>>#template#</option>
			</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td>DataSource</td>
		<td>
			<select name="dataSource" style="width:250px" onchange="this.form.submit()">
			<cfif ArrayLen(dsns) gt 1>
				<option value=""></option/>
			</cfif>
			<cfloop array="#dsns#" index="dsn">
				<option value="#dsn#"<cfif form.dataSource eq dsn> selected="selected"</cfif>>#dsn#</option>
			</cfloop>
			</select>
		</td>
	</tr>
	<cfif StructKeyExists(variables, "tables")>
	<tr>
		<td>Table</td>
		<td>
			<select name="table" style="width:250px" multiple="true">
				<option value=""></option>
				<option value="[ALL]"<cfif form.table eq "[ALL]"> selected="selected"</cfif>>-- All --</option>
			<cfloop query="tables">
				<option value="#tables.table_name#"<cfif form.table eq tables.table_name> selected="selected"</cfif>>#tables.table_name#</option>
			</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td>CFC Path</td>
		<td><input type="text" name="cfcPath" value="#form.cfcPath#" style="width:250px"/></td>
	</tr>
	<tr>
		<td>Save Path</td>
		<td><input type="text" name="savePath" value="#form.savePath#" style="width:600px"/></td>
	</tr>
	<tr>
		<td>Strip Prefix</td>
		<td><input type="text" name="stripPrefix" value="#form.stripPrefix#" style="width:250px"/></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" name="run" value="Submit"/>
			&nbsp;&nbsp;
			<input type="reset" value="Reset" onclick="document.location.href='#cgi.script_name#';return false;"/>
		</td>
	</tr>
	</cfif>
</table>
</form>
</cfoutput>

<cfif not StructKeyExists(form, "run") or not Len(form.table)>
	<cfexit/>
</cfif>

<cfif Len(form.cfcPath)>
	<cfset form.cfcPath &= "."/>
</cfif>

<cfset session.savePath = form.savePath/>

<cfif form.table eq "[ALL]">
	<cfloop query="tables">
		<cfset doTable(tables.table_name)/>
	</cfloop>
<cfelse>
	<cfloop list="#form.table#" index="tablename">
		<cfset results = doTable(tablename)/>
	</cfloop>



</cfif>

<cffunction name="doTable" output="true">
	<cfargument name="table"/>


	<cfset var local = StructNew()/>

	<cfset local.dirName = arguments.table/>
	<cfif Len(form.stripPrefix)>
		<cfset local.dirName = ReReplace(local.dirName, "^" & form.stripPrefix, "")/>
	</cfif>

	<cfset local.tempDir = form.savePath & application.generatorService.getOSFileSeparator() & application.utils.formatName(local.dirName)/>

	<cfif not DirectoryExists(local.tempDir)>
		<cfdirectory action="create" directory="#local.tempDir#">
	</cfif>

	<cfset local.results = application.generatorService.getGeneratedCFCs(
		dsn = form.dataSource,
		componentPath = form.cfcPath & arguments.table,
		table = arguments.table,
		projectPath = form.template,
		rootPath = local.tempDir,
		stripLineBreaks = true,
		stripPrefix = form.stripPrefix
	)/>

	<cfloop array="#results#" index="local.template">
		<cffile action="write" file="#local.template.getFilePath()#" output="#local.template.getContent()#"/>
		<cfoutput>Wrote #local.template.getFilePath()#<br /></cfoutput>
	</cfloop>
	<cfoutput>#RepeatString(" ", 700)#</cfoutput>
	<cfflush/>

	<cfreturn results/>
</cffunction>

<cfif form.table neq "[ALL]">
	<cfoutput>
	<table cellspacing="20">
		<tr>
			<cfloop array="#results#" index="template">
				<th><a href="##" onclick="showTemplate('#template.getPageName()#');return false;" style="text-decoration:none">#UCase(template.getPageName())#</a></th>
			</cfloop>
		</tr>
	</table>
	<script type="text/javascript">
	function showTemplate(name)
	{
	<cfloop array="#results#" index="template">
		document.getElementById('template-#template.getPageName()#').style.display = 'none';
	</cfloop>
		document.getElementById('template-' + name).style.display = 'block';
	}
	</script>
	</cfoutput>

	<cfset first = true/>
	<cfloop array="#results#" index="template">
		<cfoutput><div id="template-#template.getPageName()#"<cfif not first> style="display:none"</cfif>><h4>#template.getPageName()#</h4><textarea cols="150" rows="100">#template.getContent()#</textarea></div></cfoutput>
		<cfset first = false/>
	</cfloop>
</cfif>
