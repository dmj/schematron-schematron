<xsl:transform version="3.0" expand-text="yes"
               xmlns:fn="tag:dmaus@dmaus.name,2022:Schematron-Schematron"
               xmlns:xpath20="tag:dmaus@dmaus.name,2022:Schematron-Schematron:XPath20"
               xmlns:xpath31="tag:dmaus@dmaus.name,2022:Schematron-Schematron:XPath31"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="xpath20.xslt"/>
  <xsl:include href="xpath31.xslt"/>

  <xsl:function name="fn:validate-xpath" as="item()*">
    <xsl:param name="exprAttr" as="attribute()"/>
    <xsl:param name="queryBinding" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="$queryBinding eq 'xslt2'">
        <xsl:sequence select="xpath20:parse-XPath($exprAttr)"/>
      </xsl:when>
      <xsl:when test="$queryBinding eq 'xslt3'">
        <xsl:sequence select="xpath31:parse-XPath($exprAttr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">Unsupported query language binding: <xsl:value-of select="$queryBinding"/></xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:transform>
