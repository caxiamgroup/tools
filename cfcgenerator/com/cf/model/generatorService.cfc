<cfcomponent output="false">
	<cffunction name="init" access="public" returntype="generatorService" output="false">
		<cfargument name="templateBasePath" type="string" required="true" />

		<cfset variables.templateBasePath = arguments.templateBasePath />

		<cfset variables.code = createObject("component","cfcgenerator.com.cf.model.code.codeService").init() />
		<cfreturn this />
	</cffunction>

	<cffunction name="setAdminPassword" access="public" returntype="boolean" output="false">
		<cfargument name="adminPass" type="string" required="true" />

		<cfset var success = true />

		<cftry>
			<cfset loadAdminApi(argumentCollection = arguments) />
			<cfcatch type="any">
				<cfset success = false />
			</cfcatch>
		</cftry>
		<cfreturn success />
	</cffunction>

	<cffunction name="loadAdminApi" access="private" returntype="void" output="false">
		<cfargument name="adminPass" type="string" required="true" />
		<cfset variables.adminAPIFacade = createObject("component","cfcgenerator.com.cf.model.adminAPI.adminAPIFacade").init(arguments.adminPass) />
	</cffunction>

	<cffunction name="getDSNs" access="public" returntype="array" output="false">
		<cfreturn variables.adminAPIFacade.getDatasources() />
	</cffunction>

	<cffunction name="getDSN" access="public" returntype="cfcgenerator.com.cf.model.datasource.datasource" output="false">
		<cfargument name="dsn" type="string" required="yes" />

		<cfreturn variables.adminAPIFacade.getDatasource(arguments.dsn) />
	</cffunction>

	<cffunction name="getTables" access="public" returntype="array" output="false">
		<cfargument name="dsn" type="string" required="yes" />
		<cfreturn variables.adminAPIFacade.getDatasource(arguments.dsn).getDbms().getTables() />
	</cffunction>

	<cffunction name="getTablesQuick" access="public" returntype="query" output="false">
		<cfargument name="dsn" type="string" required="yes" />

		<cfset var tables = ""/>
		<cfdbinfo datasource="#arguments.dsn#" name="tables" type="tables"/>
		<cfreturn tables/>
	</cffunction>

	<!--- TODO: I may need a better place for this logic --->
	<cffunction name="getProjectTemplates" access="public" returntype="array" output="false">
		<cfset var qryTemplateFolders = "" />
		<cfset var arrTemplateFolders = arrayNew(1) />
		<cfdirectory name="qryTemplateFolders" action="list" directory="#variables.templateBasePath#projects" />
		<cfloop query="qryTemplateFolders">
			<!--- only directories and not the .svn dir if it exists --->
			<cfif qryTemplateFolders.type eq "Dir" and qryTemplateFolders.name neq ".svn">
				<cfset arrayAppend(arrTemplateFolders,qryTemplateFolders.name) />
			</cfif>
		</cfloop>
		<cfreturn arrTemplateFolders />
	</cffunction>

	<cffunction name="getGeneratedCFCs" access="public" returntype="array" output="false">
		<cfargument name="dsn" type="string" required="yes" />
		<cfargument name="componentPath" type="string" required="yes" />
		<cfargument name="table" type="string" required="yes" />
		<cfargument name="projectPath" type="string" required="no" default="" />
		<cfargument name="rootPath" type="string" required="no" default="" />
		<cfargument name="stripLineBreaks" type="boolean" required="no" default="false" />
		<cfargument name="stripPrefix" type="string" required="no" default="" />

		<cfset var code = arrayNew(1) />
		<cfset var i = 0 />
		<cfset var thisPage = "" />
		<cfset var separator = getOSFileSeparator() />
		<cfset var dbms = getDbms(arguments.dsn)/>

		<!--- TODO: this is a fix for if project path is default, its is passed as empty --->
		<cfif arguments.projectPath eq "default">
			<cfset arguments.projectPath = "" />
		</cfif>

		<cfif len(arguments.rootPath) and directoryExists(arguments.rootPath)>
			<cfset arguments.rootPath = arguments.rootPath & separator & replace(arguments.componentPath,".",separator,"all") />
		<cfelse>
			<cfset arguments.rootPath = "" />
		</cfif>
		<!--- configure the code template component with the dsn --->
		<cfset variables.code.configure(arguments.dsn,variables.templateBasePath,arguments.projectPath,arguments.rootPath,arguments.stripPrefix) />
		<cfset dbms.setComponentPath(arguments.componentPath) />
		<cfset dbms.setTable(arguments.table)>
		<!--- get an array containing the generated code --->
		<cfset code = variables.code.getComponents(dbms.getTableXML()) />
		<!--- try to remove extraneous line breaks and spaces that seem to appear in flex in some cases but not in CF --->

		<cfif arguments.stripLineBreaks>
			<cfloop from="1" to="#arrayLen(code)#" index="i">
				<cfset thisPage = code[i] />
				<cfset thisPage.setContent(cleanContent(thisPage.getContent()))>
			</cfloop>
		</cfif>
		<cfreturn code />
	</cffunction>

	<cffunction name="cleanContent" output="no">
		<cfargument name="content" required="yes"/>
		<cfset var local = StructNew()/>

		<cfset local.results = ""/>
		<cfset local.content = Replace(arguments.content, Chr(13), "", "all")/>
		<cfset local.lines = ListToArray(local.content, Chr(10), true)/>
		<cfset local.lastLineEmpty = true/>
		<cfloop array="#local.lines#" index="local.line">
			<cfif Len(Trim(local.line)) or not local.lastLineEmpty>
				<cfset local.results &= RTrim(local.line) & Chr(13) & Chr(10)/>
			</cfif>
			<cfset local.lastLineEmpty = (Len(Trim(local.line)) eq 0)>
		</cfloop>
		<cfreturn Trim(local.results)>
	</cffunction>

	<cffunction name="getDbms" access="private" output="no">
		<cfargument name="dsn" type="string" required="yes" />
		<cfreturn variables.adminAPIFacade.getDatasource(arguments.dsn).getDbms()/>
	</cffunction>

	<!--- TODO: I may need a better place for this logic as well --->
	<cffunction name="saveFile" access="public" returntype="string" output="false">
		<cfargument name="code" type="string" required="yes" />
		<cfargument name="filePath" type="string" required="yes" />

		<cfset var rtnMessage = "Save Succeeded" />
		<cfset var thePath = getDirectoryFromPath(arguments.filePath) />

		<cftry>
			<!--- create the directory if it doesn't currently exist --->
			<cfif not directoryExists(thePath)>
				<cfdirectory action="create" directory="#thePath#" />
			</cfif>
			<cffile action="write" file="#arguments.filePath#" output="#arguments.code#" charset="utf-8" />
			<cfcatch type="any">
				<cfset rtnMessage = "Save Failed: " & cfcatch.Message />
			</cfcatch>
		</cftry>
		<cfreturn rtnMessage />
	</cffunction>

	<!--- code supplied by Luis Majano --->
	<cffunction name="getOSFileSeparator" access="public" returntype="any" output="false" hint="Get the operating system's file separator character">
        <cfscript>
        var objFile =  createObject("java","java.lang.System");
        return objFile.getProperty("file.separator");
        </cfscript>
    </cffunction>

	<cffunction name="structToArray" output="false" access="private" returntype="array">
		<cfargument name="thisStruct" type="struct" required="true" />

		<cfset var arrReturn = arrayNew(1) />
		<cfset var thisItem = "" />
		<cfloop collection="#arguments.thisStruct#" item="thisItem">
			<cfset arrayAppend(arrReturn,arguments.thisStruct[thisItem]) />
		</cfloop>
		<cfreturn arrReturn />
	</cffunction>
</cfcomponent>