module Multilang
  def block_code(code, full_lang_name)
    if full_lang_name
      tab_class = " tab-"
      if code[0] == '!'
        tab_class = ""
        code = code[2..-1]
      elsif code[0] == '~'
        tab_class = " code-wrap "
        code = code[2..-1]
      end
      parts = full_lang_name.split('--')
      rouge_lang_name = (parts) ? parts[0] : "" # just parts[0] here causes null ref exception when no language specified
      super(code, rouge_lang_name).sub("highlight #{rouge_lang_name}") do |match|
        extra = ''
        tab_class_lang = tab_class + full_lang_name
        if tab_class_lang == ' tab-javascript--nodejs' || tab_class_lang == ' tab-ruby' || tab_class_lang == ' tab-java' || tab_class_lang == ' tab-python' || tab_class_lang == ' tab-php'
          extra = '" style="display:none'
        end
        match + tab_class_lang + extra
      end
    else
      super(code, full_lang_name)
    end
  end
end

require 'middleman-core/renderers/redcarpet'
Middleman::Renderers::MiddlemanRedcarpetHTML.send :include, Multilang
