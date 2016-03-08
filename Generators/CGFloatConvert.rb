#!/usr/bin/env ruby

require 'kiss_shot'

type  = :CGFloat
types = [:Int, :Double, :Float]

content = KissShot::Spec.run do
  line "// CGFloat+Converter.swift"
  line "// Deliria"
  line "//"
  line "// Created by Yanke Guo on 16/2/10."
  line "// Generated by KissShot https://github.com/YMXian/kiss_shot"
  line "//"
  line "// Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved."
  line "//"

  line
  line "import CoreGraphics"
  line
  line "extension #{type} {"

  types.each do |type2|
    line
    indent_up

    line "/// Convert self:#{type} to #{type2}"

    line "public var #{type2}: Swift.#{type2} {"
    indent_up
    line "return Swift.#{type2}(self)"
    indent_down
    line "}"
    indent_down
  end

  line
  indent_up
  line "/// Returns self"
  line "public var #{type}: CoreGraphics.#{type} {"
  indent_up
  line "return self"
  indent_down
  line "}"
  indent_down
  line

  line "}"

  types.each do |type2|
    line
    line "extension #{type2} {"
    line
    indent_up
    line "/// Convert #{type2} to CGFloat"
    line "public var CGFloat: CoreGraphics.CGFloat {"
    indent_up
    line "return CoreGraphics.CGFloat(self)"
    indent_down
    line "}"
    indent_down
    line
    line "}"
  end

end

puts content