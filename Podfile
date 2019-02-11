platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

    target 'StashCoach' do
    pod 'SDWebImage', '~> 4.0'

    target "StashCoachTests" do
        inherit! :search_paths
        # we have to use_frameworks for iOSSnapshotTestCase because it breaks module public header security by importing a private header into a public one. We should submit a PR and correct that so we can staticly link that lib
        pod 'iOSSnapshotTestCase'
    end
end
