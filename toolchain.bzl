def _wpieterse_cc_toolchain_config_impl(ctx):
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = ctx.attr.toolchain_name,
        target_system_name = "fill_me",
        target_cpu = "fill_me",
        target_libc = "fill_me",
        compiler = "fill_me",
    )

wpieterse_cc_toolchain_config = rule(
    implementation = _wpieterse_cc_toolchain_config_impl,
    attrs = {
        "toolchain_name": attr.string(
            mandatory = True,
            doc = "Fill me",
        ),
    },
    provides = [
        CcToolchainConfigInfo,
    ],
)
