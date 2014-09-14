Pod::Spec.new do |s|

  s.name         = "CRScrollMenu"
  s.version      = "0.1"
  s.summary      = "可以横向滑动的Menu，滑动至某项时其底部会有指示条"

  s.description  = <<-DESC
                   A longer description of CRScrollMenu in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/joeshang/CRScrollMenu"
  s.license      = "MIT" 
  s.author       = { "Joe Shang" => "shangchuanren@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/joeshang/CRScrollMenu.git", :tag => "0.1" }
  s.source_files = "CRScrollMenu/CRScrollMenu/"
  s.requires_arc = true

end
