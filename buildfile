GUVNOR_VERSION="5.4.0.Final"
package_url = "http://download.jboss.org/drools/release/#{GUVNOR_VERSION}/guvnor-distribution-#{GUVNOR_VERSION}.zip"
base_filename = File.basename(package_url)
war_file = "guvnor-#{GUVNOR_VERSION}-jboss-as-7.0.war"

package_zip = download("downloads/#{base_filename}" => package_url)

task "unzip" do
  unzip_task = unzip("target" => package_zip)
  unzip_task.from_path("guvnor-distribution-#{GUVNOR_VERSION}/binaries").include(war_file)
  unzip_task.extract
end

bean_jar = file("target/#{war_file}" => "unzip")

define "guvnor-distribution" do
  project.version = "#{GUVNOR_VERSION}-#{`git describe --tags --always`.strip}"
  project.group = "au.gov.vic.dse.fire.org.drools"
  compile.options.source = '1.6'
  compile.options.target = '1.6'
  compile.options.lint = 'all'

  compile.with :slf4j_api,
               :glassfish_security,
               :picketlink_idm_api,
               :picketlink_idm_core,
               :javax_inject,
               :seam_security,
               :seam_security_api

  package(:war).tap do |war|
    war.merge(bean_jar).exclude("WEB-INF/lib/javassist-3.14.0-GA.jar").exclude("WEB-INF/web.xml").exclude("WEB-INF/beans.xml")
  end
end