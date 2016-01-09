module Fastlane
  module Actions
    module SharedValues
      COPY_LEGACY_COVERAGE_DATA_CUSTOM_VALUE = :COPY_LEGACY_COVERAGE_DATA_CUSTOM_VALUE
    end

    # To share this integration with the other fastlane users:
    # - Fork https://github.com/KrauseFx/fastlane
    # - Clone the forked repository
    # - Move this integration into lib/fastlane/actions
    # - Commit, push and submit the pull request

    class CopyLegacyCoverageDataAction < Action
      def self.run(params)

        new_cov_path = new_coverage_path(params)
        old_cov_path = old_coverage_path(params)

        sh "cp -r #{new_cov_path}/ #{old_cov_path}/"
      end

      def self.old_coverage_path(options)
        project_name = options[:project_name]
        scheme = options[:scheme]
        arch = options[:arch]

        initial_path = "#{Dir.home}/Library/Developer/Xcode/DerivedData/"
        match = find_project_dir(project_name,initial_path)
        end_path = "/Build/Intermediates/#{project_name}.build/Debug-iphonesimulator/#{scheme}.build/Objects-normal/#{arch}/"
        "#{initial_path}#{match}#{end_path}"
      end

      def self.new_coverage_path(options)
        project_name = options[:project_name]
        scheme = options[:scheme]
        arch = options[:arch]

        initial_path = "#{Dir.home}/Library/Developer/Xcode/DerivedData/"
        match = find_project_dir(project_name,initial_path)
        end_path = "/Build/Intermediates/CodeCoverage/#{project_name}/Intermediates/#{project_name}.build/Debug-iphonesimulator/#{scheme}.build/Objects-normal/#{arch}"
        "#{initial_path}#{match}#{end_path}"
      end

      def self.find_project_dir(project_name, path)
         `ls -t #{path}| grep #{project_name} | head -1`.to_s.gsub(/\n/, "")
      end
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Copy legacy coverage data gcda,gcno files from new structure under CodeCoverage
        folder inside DerivedData, to old structure that lcov action of fastlane uses"
      end

      def self.details
        # Optional:
        # this is your change to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :project_name,
                             env_name: "FL_COPY_LEGACY_COVERAGE_PROJECT_NAME",
                             description: "Name of the project"),

          FastlaneCore::ConfigItem.new(key: :scheme,
                                       env_name: "FL_COPY_LEGACY_COVERAGE_SCHEME",
                                       description: "Scheme of the project"),

          FastlaneCore::ConfigItem.new(key: :arch,
                                       env_name: "FL_COPY_LEGACY_COVERAGE_ARCH",
                                       description: "The build arch where will search .gcda files",
                                       default_value: "i386"),
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["thiagolioy"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
