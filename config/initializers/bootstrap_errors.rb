ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe

  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, input, select"
  elements.each do |e|
    next if e['type'] == 'hidden'
    
    if e.node_name.eql? 'label'
      html = %(<div class="clearfix has-error">#{e}</div>).html_safe
    elsif e.node_name.eql?('input') || e.node_name.eql?('select')
      if instance.error_message.kind_of?(Array)
        html = %(<div class="clearfix has-error">#{html_tag}<span class="help-inline has-error">&nbsp;#{instance.error_message.join(', ')}</span></div>).html_safe
      else
        html = %(<div class="clearfix has-error">#{html_tag}<span class="help-inline has-error">&nbsp;#{instance.error_message}</span></div>).html_safe
      end
    end
  end
  html
end