# -*- coding: utf-8 -*-
module BrainDamageHelper
  def r(partial, locals = {})
    render :partial => partial, :locals => locals
  end

  def bd(partial, locals = {})
    r "brain_damage/#{partial}", :locals => locals
  end

  def bd_id
    "brain-damage-#{(0...16).map { (65 + rand(26)).chr }.join.downcase}"
  end

  def bd_actions(locals = {}, &block)
    locals = {:show => false, :delete => true, :edit => true, :block => block}.merge(locals)
    render :partial => 'brain_damage/shared/actions', :locals => locals
  end

  def ajax_sensible_field_wrapper(object, method, show = true, html = {})
    html[:tag] ||= 'tr'
    html[:class] ||= ''
    html[:class] += ' sensible-to-ajax'

    content_tag(html[:tag], { :class => html[:class], :data => { :ajax_sensibility_field => method }}) do
      yield if block_given? and show
    end
  end
end
