module Lockme
  module JsonUtils
    def to_json
      @data.to_json.force_encoding('UTF-8').each_codepoint.reduce('') {|str, c| str << (c > 127 ? '\u'+c.to_s(16).rjust(4, '0') : c.chr) }
    end
  end
  private_constant :JsonUtils
end
