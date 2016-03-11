module BrainDamage
  class ViewsManager
    VIEWS_PATH = File.expand_path("../../resource/templates/views/", __FILE__)

    def initialize(args = {})
      if args.is_a? Symbol
        @args = { :type => args }
      else
        @args = args
      end

      @type = @args[:type]
      @args[:special_views] ||= []
    end

    def available_views
      return [] if @type == :none
      common_views + specific_views + special_views
    end

    private
    def specific_views
      views_on_dir @type.to_s
    end

    def common_views
      views_on_dir 'common'
    end

    def special_views
      @args[:special_views].map { |special_view| "special/#{special_view}" }
    end

    def views_on_dir(dir)
      Dir[VIEWS_PATH+"/#{dir}/*"].map{ |file| dir+'/'+file.split('/').last.gsub('.html.haml', '') }
    end
  end
end
