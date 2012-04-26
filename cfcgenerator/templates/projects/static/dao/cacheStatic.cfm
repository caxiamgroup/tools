
	<%cffunction name="cacheStatic" output="no"%>
		<%cfquery name="variables.data"%>
			SELECT *
			FROM       #root.bean.dbTable.xmlAttributes.name#
		<%/cfquery%>
	<%/cffunction%>

