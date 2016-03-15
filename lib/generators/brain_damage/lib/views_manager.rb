module BrainDamage
  class ViewsManager
    attr_reader :dynamic_views

    VIEWS_PATH = File.expand_path("../../resource/templates/views/", __FILE__)

    def initialize(args = {})
      if args.is_a? Symbol
        @args = { :type => args }
      else
        @args = args
      end

      @type = @args[:type]
      @special_views = @args[:special_views] || []
      @dynamic_views = []
    end

    def available_views
      return [] if @type == :none
      common_views + specific_views + special_views
    end

    def add_special_view(special_view)
      @special_views << special_view unless @special_views.include? special_views
    end

    def add_dynamic_view(file_name, contents)
      @dynamic_views << { file_name: file_name, contents: contents }
    end

    private
    def specific_views
      views_on_dir @type.to_s
    end

    def common_views
      views_on_dir 'common'
    end

    def special_views
      views_on_dir('special').select { |file|
        @special_views.select { |special_view_name|
          file.include? special_view_name
        }.any?
      }
    end

    def views_on_dir(dir)
      Dir[VIEWS_PATH+"/#{dir}/*"].map{ |file| dir+'/'+file.split('/').last.gsub('.html.haml', '') }
    end
  end
end
