namespace Choc13.Function

open Microsoft.Azure.Functions.Worker
open Microsoft.Extensions.Logging

type Execute(logger: ILogger<Execute>) =
    [<Function("Execute")>]
    member _.Run([<TimerTrigger("0 */5 * * * *")>] timer: TimerInfo) =
        logger.LogInformation($"Hello at {System.DateTime.UtcNow} from an Azure function using F# on .NET 5.")
