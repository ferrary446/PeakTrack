def build_lane
    setup_ci if ENV["CI"]

    clear_derived_data(
        derived_data_path: "~/Library/Developer/Xcode/DerivedData"
    )

    build_app(
        project: "PeakTrack.xcodeproj",
        scheme: "PeakTrack",
        clean: true,
        skip_package_ipa: true,
        skip_archive: true,
        skip_codesigning: true
    )
end
