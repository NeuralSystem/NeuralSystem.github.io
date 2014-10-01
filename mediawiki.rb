module Jekyll
  class MediaWikiConverter < Converter
    safe true
    # http://www.rubydoc.info/github/mojombo/jekyll/master/frames/Jekyll/Converters/Textile
    # Valid options are: 
    #   :lowest, :low, :normal, :high, :highest
    priority :lowest

    def setup 
      return if @setup
      require 'wikicloth'
      @setup = true
    rescue
      STDERR.puts 'do `gem install wikicloth`'
      raise FatalException.new("Missing dependency: wikicloth")
    end

    def matches(ext)
      ext =~ /^\.mediawiki$/i
    end ### def matches

    def output_ext(ext)
      ".html"
    end ### def output_ext

    def convert(content)
      #require 'mediacloth'
      #MediaCloth::wiki_to_html(content)

      setup
#puts "Internal Links: #{wiki.internal_links.size}"
#puts "External Links: #{wiki.external_links.size}"
#puts "References: #{wiki.references.size}"
#puts "Categories: #{wiki.categories.size} [#{wiki.categories.join(",")}]"
#puts "Languages: #{wiki.languages.size} [#{wiki.languages.keys.join(",")}]"

#      content = content.gsub(/<(source|code|pre)>/, "{% highlight %}").gsub(/<\/(source|code|pre)>/, "{% endhighlight %}")
      content = content.gsub("[[", "[[/").gsub("[[/Image:", "[[Image:")

      @wiki = WikiCloth::Parser.new({
                :data   => "__NOTOC__" + content,
                :params => {}
                }).to_html(:noedit => true)
    end ### def convert
  end ### class MediaWikiConverter
end ### module Jekyll

