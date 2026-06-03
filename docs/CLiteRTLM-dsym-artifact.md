# CLiteRTLM dSYM Artifact

`v0.12.1` publishes a rebuilt `CLiteRTLM.xcframework.zip` for the upstream
LiteRT-LM `v0.12.0` source with matching dSYMs included in the XCFramework.

The upstream Google `v0.12.0` binary artifact does not include dSYMs. App Store
validation requires a dSYM whose UUID matches the embedded
`CLiteRTLM.framework` binary.

## Build Inputs

- Upstream source: `google-ai-edge/LiteRT-LM` tag `v0.12.0`
- Bazel build command:

```bash
bazelisk build //swift:CLiteRTLM --apple_generate_dsym --config=ios_arm64
```

The upstream `v0.12.0` Bazel config needed two local build-only adjustments on
Apple Silicon:

- Add Rust target triples `x86_64-apple-darwin` and `x86_64-apple-ios`.
- Build the simulator slice as `arm64` only. The legacy `x86_64` simulator link
  fails in `v0.12.0` with missing constrained-decoding symbols.

## Package Shape

The release asset is a zip with this top-level bundle:

```text
CLiteRTLM.xcframework/
```

It contains:

- `ios-arm64/CLiteRTLM.framework`
- `ios-arm64/dSYMs/CLiteRTLM_ios_device.framework.dSYM`
- `ios-arm64-simulator/CLiteRTLM.framework`
- `ios-arm64-simulator/dSYMs/CLiteRTLM_ios_simulator.framework.dSYM`

## Verification

```bash
dwarfdump --uuid CLiteRTLM.xcframework/ios-arm64/CLiteRTLM.framework/CLiteRTLM
dwarfdump --uuid CLiteRTLM.xcframework/ios-arm64/dSYMs/CLiteRTLM_ios_device.framework.dSYM
dwarfdump --uuid CLiteRTLM.xcframework/ios-arm64-simulator/CLiteRTLM.framework/CLiteRTLM
dwarfdump --uuid CLiteRTLM.xcframework/ios-arm64-simulator/dSYMs/CLiteRTLM_ios_simulator.framework.dSYM
swift package compute-checksum CLiteRTLM.xcframework.zip
```

Expected checksum for `v0.12.1`:

```text
2036b80079b2ba58ad71997e59ec12ce0fdccfdb51fa26455fab351ac8c98a29
```
