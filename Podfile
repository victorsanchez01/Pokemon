platform :ios, '17.0'

target 'Pokemon' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pokemon
pod 'Kingfisher'

  target 'PokemonTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PokemonUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64 i386"
    end
  end
end
