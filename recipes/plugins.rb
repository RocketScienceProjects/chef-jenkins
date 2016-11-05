#This recipe will consume the plugin provider to install plugins

plugins = ['greenballs', 'maven-plugin']

plugins.each do |plugin|

  jenkins_plugin plugin

end
