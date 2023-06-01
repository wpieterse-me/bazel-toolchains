def _wpieterse_cc_toolchain_config_impl(ctx):
    pass

wpieterse_cc_toolchain_config = rule(
    implementation = _wpieterse_cc_toolchain_config_impl,
    attrs = {
    },
    provides = [
        CcToolchainConfigInfo,
    ],
)
