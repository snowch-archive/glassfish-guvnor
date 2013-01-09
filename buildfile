

bean_jar = file("/home/snowch/repos_thirdparty/guvnor-distribution-5.4.0.Final/binaries/guvnor-5.4.0.Final-jboss-as-7.0.war")

define "guvnor-distribution" do
  project.version = "0.0.1"
  project.group = "net.christophersnow"
  compile.options.source = '1.6'
  compile.options.target = '1.6'
  compile.options.lint = 'all'

  package(:war).tap do |war|
    war.merge(bean_jar).exclude("WEB-INF/lib/javassist-3.14.0-GA.jar").exclude("WEB-INF/web.xml")
  end
end
