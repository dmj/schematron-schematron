<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <sch:ns prefix="fn" uri="tag:dmaus@dmaus.name,2022:Schematron-Schematron"/>
  <sch:ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
  <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>

  <sch:let name="queryBinding" value="'xslt2'"/>

  <xsl:include href="functions.xsl"/>

  <sch:pattern>
    <sch:rule context="sch:rule/@context | sch:assert/@test | sch:report/@test | sch:value-of/@select | sch:let/@value | sch:name/@path | sch:pattern/@documents | xsl:copy-of/@select">
      <sch:let name="queryBinding" value="lower-case((ancestor::sch:schema/@queryBinding, $queryBinding, 'xslt')[1])"/>
      <sch:let name="result" value="fn:validate-xpath(., $queryBinding)"/>
      <sch:let name="invalid" value="fn:find-invalid-functions(fn:get-xpath-functions($result, $queryBinding), $queryBinding)"/>
      <sch:report test="$result/ERROR">
        <sch:value-of select="$result/ERROR"/>
      </sch:report>
      <sch:report test="exists($invalid)" role="WARNING">
        The XPath expression may contain one or more unknown function: <sch:value-of select="fn:pretty-print-function($invalid)"/>.
      </sch:report>
    </sch:rule>
  </sch:pattern>

</sch:schema>
