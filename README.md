# sny_simpleSelfDriving
 A simple standalone self driving resource made for FiveM with support for QB-Core and ESX
 
### Preview
- Resource Monitor
![Resource Monitor](https://i.imgur.com/fOUVzSt.png)
- Video

### Installation
- 1.Download the [latest release](https://github.com/sandy6078/sny_simpleSelfDriving/releases)
- 2.Unzip the file
- 3.Rename the folder to `sny_simpleSelfDriving`
- 4.Add `ensure sny_simpleSelfDriving` anywhere to `server.cfg`
- (OPTIONAL) Run `sny_simpleSelfDriving.sql` (only if `config.useMySQL` is set to `true`)
- (OPTIONAL) Uncomment `@oxmysql/lib/MySQL.lua` in `server_scripts`
- (OPTIONAL) Uncomment `oxmysql` in `dependencies`
- 5.Play around!

### Todo
- Preview
- Documentation

### Dependency
- [oxmysql](https://github.com/overextended/oxmysql) (only if `config.useMySQL` is set to `true`)

### References
- Thanks to [TomGrobbe](https://github.com/TomGrobbe) for his work on [Driving Style Calculator](https://vespura.com/fivem/drivingstyle/)
- Thanks to [Overextended group](https://github.com/TomGrobbe) for their work on [oxmysql](https://github.com/overextended/oxmysql)