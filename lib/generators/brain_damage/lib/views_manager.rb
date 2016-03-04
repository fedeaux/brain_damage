module BrainDamage
  class ViewsManager
    VIEWS_PATH = File.expand_path("../../resource/templates/views/", __FILE__)

    def initialize(args = {})
      if args.is_a? Symbol
        @args = { :type => args }
      else
        @args = args
      end
    end

    def available_views
      common_views + specific_views
    end

    private
    def specific_views
      views_on_dir @args[:type].to_s
    end

    def common_views
      views_on_dir 'common'
    end

    def views_on_dir(dir)
      Dir[VIEWS_PATH+"/#{dir}/*"].map{ |file| dir+'/'+file.split('/').last.gsub('.html.haml', '') }
    end
  end
end
