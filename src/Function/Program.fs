module Choc13.Function.Program

open Microsoft.Extensions.Hosting

let host =
    HostBuilder()
        .ConfigureFunctionsWorkerDefaults()
        .Build()

host.Run()
