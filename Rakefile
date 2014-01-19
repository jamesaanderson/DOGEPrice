# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'DOGEPrice'
  app.icon = 'dogecoin.png'
  app.codesign_for_release = false
  app.info_plist['LSUIElement'] = true
  app.deployment_target = '10.7'
end
