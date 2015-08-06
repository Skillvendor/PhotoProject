 require "mini_magick"
 require 'rbconfig'
 
  is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

  if is_windows
    class MiniMagick::CommandBuilder
      def escape_string( value )
        return '"' + value.gsub( '\\', '\\\\' ).gsub( '"', '\\"' ) + '"'
      end
    end
  end