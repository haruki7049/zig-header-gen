const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const header_gen = b.addModule("header_gen", .{ .root_source_file = b.path("src/root.zig"), });
    const example = b.addExecutable(.{
        .name = "example",
        .root_source_file = b.path("example/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    example.root_module.addImport("header_gen", header_gen);
    b.installArtifact(example);
}
