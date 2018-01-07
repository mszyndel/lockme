# frozen_string_literal: true

#:nodoc:
module Lockme
  # Mixin providing JSON encoding method compatible with LockMe API
  module JsonUtils
    def to_json
      utf_str = @data.to_h.to_json.force_encoding('UTF-8')
      utf_str.each_codepoint.reduce(+'') do |str, codepoint|
        str << if codepoint > 127
                 '\u' + codepoint.to_s(16).rjust(4, '0')
               else
                 codepoint.chr
               end
      end
    end
  end
  private_constant :JsonUtils
end
