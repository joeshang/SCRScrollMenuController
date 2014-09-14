Pod::Spec.new do |s|

  s.name         = "CRScrollMenuController"
  s.version      = "0.2"
  s.summary      = "A container view controller with scrollable menu and scrollable content"

  s.description  = <<-DESC
                   A longer description of CRScrollMenuController in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/joeshang/CRScrollMenuController"
  s.license      = "MIT" 
  s.author       = { "Joe Shang" => "shangchuanren@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/joeshang/CRScrollMenuController.git", :tag => "0.2" }
  s.source_files = "CRScrollMenu""
  s.requires_arc = true

end
