# ssis-whalexec
SSIS dtexec on docker image - really? yep

## this is a POC
I gotta test it better but, I since deal with PROD only, I'll need to blame the outage on someone's else errr I mean, I cant test it :)

## how daheck?
should work very similar to dtexec on windows - urgh! like:

### clone the repo
### build the docker image
<pre>docker build ssis-whalexec .</pre>

### bring the container up
<pre>docker run -dt --name sameolwhale -v $(pwd):/root ssis-whalexec</pre>

### execute your package
<pre>docker exec -t sameolwhale dtexec /h
Microsoft (R) SQL Server Execute Package Utility
Version 15.0.4063.15 for 64-bit
Copyright (C) 2019 Microsoft. All rights reserved.

Usage: DTExec /option [value] [/option [value]] ...
Options are case-insensitive.
A hyphen (-) may be used in place of a forward slash (/).
/Ca[llerInfo]
/CheckF[ile]        [Filespec]
/Checkp[ointing]    [{On | Off}] (On is the default)
/Com[mandFile]      Filespec
/Conf[igFile]       Filespec
/Conn[ection]       IDOrName;ConnectionString
/Cons[oleLog]       [[DispOpts];[{E | I};List]]
                    DispOpts = any one or more of N, C, O, S, G, X, M, or T.
                    List = {EventName | SrcName | SrcGuid}[;List]
/De[crypt]          Password
/DT[S]              PackagePath
/Dump               code[;code[;code[;...]]]
/DumpOnErr[or]
/Env[Reference]     id of an Environment in the SSIS catalog
/F[ile]             Filespec
/H[elp]             [Option]
/IS[Server]         Full path to the package in the SSIS catalog
/L[ogger]           ClassIDOrProgID;ConfigString
/M[axConcurrent]    ConcurrentExecutables
/Pack[age]          Package to run inside of the project
/Par[ameter]        [$Package::|$Project::|$ServerOption::]parameter_name[(data_type)];literal_value
/P[assword]         Password
/Proj[ect]          Project file to use
/Rem[ark]           [Text]
/Rep[orting]        Level[;EventGUIDOrName[;EventGUIDOrName[...]]
                    Level = N or V or any one or more of E, W, I, C, D, or P.
/Res[tart]          [{Deny | Force | IfPossible}] (Force is the default)
/Set                PropertyPath;Value
/Ser[ver]           ServerInstance
/SQ[L]              PackagePath
/Su[m]
/U[ser]             User name
/Va[lidate]
/VerifyB[uild]      Major[;Minor[;Build]]
/VerifyP[ackageid]  PackageID
/VerifyS[igned]
/VerifyV[ersionid]  VersionID
/VLog               [Filespec]
/W[arnAsError]
/X86
</pre>

## rickrolls
- MS says SQLServer integration services is not yet ready to work on containers due to this to that and blah blah blah... well... hold by coffee - again, it's a POC.
- you can sure make use of cron either on container or host, change the entrypoint to make it an ephemeral run or make a wrapper your own. 
- mind the volume mappings when running the container
- I've learned that if you're on MacOS as host OS, you gotta run this container as privileged - beats me
- I've experimented some different base images for this but turned out that the MS one is the best fit (Ubuntu focal 20.04.2 LTS deb bullseye/sid)
