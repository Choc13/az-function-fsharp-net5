namespace Choc13.Function

open Microsoft.Azure.Functions.Worker
open Microsoft.Extensions.Logging

type Execute() =
    [<Function("Execute")>]
    [<TimerTrigger("0 */5 * * * *")>]
    member _.Run(logger: ILogger<Execute>) =
        logger.LogInformation($"Hello at {System.DateTime.UtcNow} from an Azure function using F# on .NET 5.")
