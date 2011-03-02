<cfoutput>
component extends="models.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#._#request.templateUtils.formatName(root.bean.xmlAttributes.name)#" entityName="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#" persistent="true" table="#root.bean.dbTable.xmlAttributes.name#" output="false"
{

}
</cfoutput>
