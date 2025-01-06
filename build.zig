const std = @import("std");

// This build.zig is only used as an example of using header_gen

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // HEADER GEN BUILD STEP
    const header_gen = b.addModule("header_gen", .{
        .root_source_file = b.path("src/header_gen.zig"),
    });
    const exe = b.addExecutable(.{
        .name = "example",
        .root_source_file = b.path("src/example/exports.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("header_gen", header_gen);
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("headergen", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
