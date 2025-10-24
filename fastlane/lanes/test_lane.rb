def test_lane
    scan(
      project: "PeakTrack.xcodeproj",
      scheme: "PeakTrack",
      clean: true,
      devices: ["iPhone 16"],
      code_coverage: true,
      result_bundle: true,
      buildlog_path: "fastlane/logs"
    )
end
