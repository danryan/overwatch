require 'bundler'
Bundler::GemHelper.install_tasks


$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require 'overwatch'

namespace :overwatch do 
  desc "Load up sample data"
  task :data do
    Mongoid.master.collections.select do |collection|
      collection.drop unless collection.name =~ /system/
    end
    host1 = Overwatch::Node.create(:name => "host1.example.com")
    host2 = Overwatch::Node.create(:name => "host2.example.com")
    host3 = Overwatch::Node.create(:name => "host3.example.com")
    
    [host1, host2, host3].each do |node|
      data = {"languages"=>
        {"ruby"=>
          {"platform"=>"x86_64-darwin10.7.3",
           "version"=>"1.9.2",
           "release_date"=>"2011-02-18",
           "target"=>"x86_64-apple-darwin10.7.3",
           "target_cpu"=>"x86_64",
           "target_vendor"=>"apple",
           "target_os"=>"darwin10.7.3",
           "host"=>"i386-apple-darwin10.7.3",
           "host_cpu"=>"i386",
           "host_os"=>"darwin10.7.3",
           "host_vendor"=>"apple",
           "bin_dir"=>"/Users/dan/.rvm/rubies/ruby-1.9.2-p180/bin",
           "ruby_bin"=>"/Users/dan/.rvm/rubies/ruby-1.9.2-p180/bin/ruby",
           "gems_dir"=>"/Users/dan/.rvm/gems/ruby-1.9.2-p180"},
         "c"=>
          {"gcc"=>
            {"version"=>"4.2.1",
             "description"=>"gcc version 4.2.1 (Apple Inc. build 5666) (dot 3)"}},
         "erlang"=>
          {"version"=>"5.8.3",
           "options"=>["SMP", "ASYNC_THREADS", "HIPE"],
           "emulator"=>"BEAM"},
         "java"=>
          {"version"=>"1.6.0_24",
           "runtime"=>
            {"name"=>"Java(TM) SE Runtime Environment",
             "build"=>"1.6.0_24-b07-334-10M3326"}},
         "perl"=>{"version"=>"5.10.0", "archname"=>"darwin-thread-multi-2level"},
         "php"=>{"version"=>"5.3.4", "builddate"=>"Jan 17 2011"},
         "python"=>{"version"=>"2.6.1", "builddate"=>"Aug 2 2010, 20:10:18"}},
       "kernel"=>
        {"name"=>"Darwin",
         "release"=>"10.7.3",
         "version"=>
          "Darwin Kernel Version 10.7.3: Sun Mar  6 13:37:56 PST 2011; root:xnu-1504.14.2~1/RELEASE_X86_64",
         "machine"=>"x86_64",
         "modules"=>
          {"com.apple.iokit.IOACPIFamily"=>
            {"version"=>"1.3.0", "size"=>16384, "index"=>"8", "refcount"=>"23"},
           "com.apple.iokit.IOPCIFamily"=>
            {"version"=>"2.6.2", "size"=>90112, "index"=>"9", "refcount"=>"33"},
           "com.apple.driver.AppleACPIPlatform"=>
            {"version"=>"1.3.6", "size"=>282624, "index"=>"10", "refcount"=>"2"},
           "com.apple.driver.AppleIntelCPUPowerManagement"=>
            {"version"=>"142.4.1", "size"=>147456, "index"=>"11", "refcount"=>"0"},
           "com.apple.iokit.IOStorageFamily"=>
            {"version"=>"1.6.3", "size"=>106496, "index"=>"12", "refcount"=>"9"},
           "com.apple.driver.DiskImages"=>
            {"version"=>"289", "size"=>73728, "index"=>"13", "refcount"=>"0"},
           "com.apple.iokit.CHUDKernLib"=>
            {"version"=>"365", "size"=>24576, "index"=>"14", "refcount"=>"2"},
           "com.apple.iokit.CHUDProf"=>
            {"version"=>"366", "size"=>53248, "index"=>"15", "refcount"=>"0"},
           "com.apple.iokit.CHUDUtils"=>
            {"version"=>"364", "size"=>36864, "index"=>"16", "refcount"=>"0"},
           "com.apple.nke.applicationfirewall"=>
            {"version"=>"2.1.11", "size"=>32768, "index"=>"17", "refcount"=>"0"},
           "com.apple.security.TMSafetyNet"=>
            {"version"=>"6", "size"=>12288, "index"=>"18", "refcount"=>"0"},
           "com.apple.security.quarantine"=>
            {"version"=>"0", "size"=>16384, "index"=>"20", "refcount"=>"0"},
           "com.apple.security.sandbox"=>
            {"version"=>"1", "size"=>32768, "index"=>"21", "refcount"=>"0"},
           "com.apple.driver.AppleIntelCPUPowerManagementClient"=>
            {"version"=>"142.4.1", "size"=>12288, "index"=>"22", "refcount"=>"0"},
           "com.apple.driver.AppleAPIC"=>
            {"version"=>"1.4", "size"=>12288, "index"=>"23", "refcount"=>"0"},
           "com.apple.iokit.IOSMBusFamily"=>
            {"version"=>"1.1", "size"=>8192, "index"=>"24", "refcount"=>"3"},
           "com.apple.driver.AppleACPIEC"=>
            {"version"=>"1.3.6", "size"=>24576, "index"=>"25", "refcount"=>"0"},
           "com.apple.driver.AppleSMBIOS"=>
            {"version"=>"1.7", "size"=>16384, "index"=>"26", "refcount"=>"0"},
           "com.apple.driver.AppleHPET"=>
            {"version"=>"1.5", "size"=>12288, "index"=>"27", "refcount"=>"0"},
           "com.apple.driver.AppleRTC"=>
            {"version"=>"1.3.1", "size"=>24576, "index"=>"28", "refcount"=>"0"},
           "com.apple.iokit.IOHIDFamily"=>
            {"version"=>"1.6.6", "size"=>274432, "index"=>"29", "refcount"=>"7"},
           "com.apple.driver.AppleACPIButtons"=>
            {"version"=>"1.3.6", "size"=>16384, "index"=>"30", "refcount"=>"0"},
           "com.apple.driver.AppleEFIRuntime"=>
            {"version"=>"1.4.0", "size"=>12288, "index"=>"31", "refcount"=>"1"},
           "com.apple.iokit.IOUSBFamily"=>
            {"version"=>"4.2.0", "size"=>237568, "index"=>"32", "refcount"=>"13"},
           "com.apple.driver.AppleUSBEHCI"=>
            {"version"=>"4.2.0", "size"=>94208, "index"=>"34", "refcount"=>"0"},
           "com.apple.iokit.IOAHCIFamily"=>
            {"version"=>"2.0.5", "size"=>28672, "index"=>"35", "refcount"=>"3"},
           "com.apple.driver.AppleAHCIPort"=>
            {"version"=>"2.1.6", "size"=>94208, "index"=>"36", "refcount"=>"0"},
           "com.apple.driver.AppleSmartBatteryManager"=>
            {"version"=>"160.0.0", "size"=>32768, "index"=>"37", "refcount"=>"0"},
           "com.apple.driver.AppleEFINVRAM"=>
            {"version"=>"1.4.0", "size"=>28672, "index"=>"38", "refcount"=>"0"},
           "com.apple.iokit.IONetworkingFamily"=>
            {"version"=>"1.10", "size"=>106496, "index"=>"39", "refcount"=>"5"},
           "com.apple.iokit.IO80211Family"=>
            {"version"=>"320.1", "size"=>151552, "index"=>"41", "refcount"=>"1"},
           "com.apple.driver.AirPort.Brcm4331"=>
            {"version"=>"429.10.2", "size"=>1904640, "index"=>"42", "refcount"=>"0"},
           "com.apple.driver.AppleSDXC"=>
            {"version"=>"1.0.2", "size"=>61440, "index"=>"43", "refcount"=>"0"},
           "com.apple.iokit.IOFireWireFamily"=>
            {"version"=>"4.2.6", "size"=>307200, "index"=>"44", "refcount"=>"2"},
           "com.apple.driver.AppleFWOHCI"=>
            {"version"=>"4.7.3", "size"=>163840, "index"=>"45", "refcount"=>"0"},
           "com.apple.iokit.IOUSBUserClient"=>
            {"version"=>"4.2.0", "size"=>8192, "index"=>"46", "refcount"=>"1"},
           "com.apple.driver.AppleUSBHub"=>
            {"version"=>"4.2.0", "size"=>73728, "index"=>"47", "refcount"=>"0"},
           "com.apple.iokit.IOAHCIBlockStorage"=>
            {"version"=>"1.6.3", "size"=>86016, "index"=>"48", "refcount"=>"0"},
           "com.apple.iokit.IOSCSIArchitectureModelFamily"=>
            {"version"=>"2.6.6", "size"=>102400, "index"=>"49", "refcount"=>"3"},
           "com.apple.iokit.IOAHCISerialATAPI"=>
            {"version"=>"1.2.5", "size"=>36864, "index"=>"50", "refcount"=>"0"},
           "com.apple.BootCache"=>
            {"version"=>"31", "size"=>16384, "index"=>"52", "refcount"=>"0"},
           "com.apple.driver.XsanFilter"=>
            {"version"=>"402.1", "size"=>12288, "index"=>"54", "refcount"=>"0"},
           "com.apple.iokit.IOCDStorageFamily"=>
            {"version"=>"1.6.1", "size"=>36864, "index"=>"55", "refcount"=>"3"},
           "com.apple.iokit.IODVDStorageFamily"=>
            {"version"=>"1.6", "size"=>28672, "index"=>"56", "refcount"=>"2"},
           "com.apple.iokit.IOBDStorageFamily"=>
            {"version"=>"1.6", "size"=>28672, "index"=>"57", "refcount"=>"1"},
           "com.apple.iokit.IOSCSIMultimediaCommandsDevice"=>
            {"version"=>"2.6.6", "size"=>77824, "index"=>"58", "refcount"=>"0"},
           "com.apple.iokit.SCSITaskUserClient"=>
            {"version"=>"2.6.6", "size"=>28672, "index"=>"59", "refcount"=>"0"},
           "com.apple.driver.AppleUSBComposite"=>
            {"version"=>"3.9.0", "size"=>16384, "index"=>"60", "refcount"=>"1"},
           "com.apple.driver.AppleUSBMergeNub"=>
            {"version"=>"4.2.0", "size"=>20480, "index"=>"61", "refcount"=>"0"},
           "com.apple.iokit.IOUSBHIDDriver"=>
            {"version"=>"4.2.0", "size"=>24576, "index"=>"62", "refcount"=>"4"},
           "com.apple.driver.AppleIRController"=>
            {"version"=>"303.8", "size"=>20480, "index"=>"63", "refcount"=>"0"},
           "com.apple.driver.AppleUSBTCKeyboard"=>
            {"version"=>"201.2", "size"=>16384, "index"=>"64", "refcount"=>"0"},
           "com.apple.driver.AppleUSBMultitouch"=>
            {"version"=>"207.5", "size"=>53248, "index"=>"66", "refcount"=>"0"},
           "com.apple.driver.AppleUSBTCButtons"=>
            {"version"=>"201.2", "size"=>12288, "index"=>"70", "refcount"=>"0"},
           "com.apple.iokit.IOGraphicsFamily"=>
            {"version"=>"2.2", "size"=>163840, "index"=>"71", "refcount"=>"16"},
           "com.apple.driver.AppleIntelSNBGraphicsFB"=>
            {"version"=>"6.3.2", "size"=>172032, "index"=>"72", "refcount"=>"0"},
           "com.apple.iokit.IONDRVSupport"=>
            {"version"=>"2.2", "size"=>57344, "index"=>"73", "refcount"=>"6"},
           "com.apple.driver.AppleIntelHDGraphics"=>
            {"version"=>"6.3.2", "size"=>872448, "index"=>"74", "refcount"=>"0"},
           "com.apple.kext.ATISupport"=>
            {"version"=>"6.3.2", "size"=>1159168, "index"=>"75", "refcount"=>"2"},
           "com.apple.kext.ATI6000Controller"=>
            {"version"=>"6.3.2", "size"=>172032, "index"=>"76", "refcount"=>"0"},
           "com.apple.ATIRadeonX3000"=>
            {"version"=>"6.3.2", "size"=>2715648, "index"=>"79", "refcount"=>"0"},
           "com.apple.driver.AppleBacklightExpert"=>
            {"version"=>"1.0.1", "size"=>8192, "index"=>"80", "refcount"=>"1"},
           "com.apple.driver.AppleGraphicsControl"=>
            {"version"=>"2.10.5", "size"=>122880, "index"=>"82", "refcount"=>"0"},
           "com.apple.driver.AppleLPC"=>
            {"version"=>"1.5.1", "size"=>12288, "index"=>"83", "refcount"=>"0"},
           "com.apple.iokit.AppleProfileFamily"=>
            {"version"=>"41.4", "size"=>217088, "index"=>"87", "refcount"=>"6"},
           "com.apple.kext.OSvKernDSPLib"=>
            {"version"=>"1.3", "size"=>20480, "index"=>"93", "refcount"=>"2"},
           "com.apple.driver.AudioIPCDriver"=>
            {"version"=>"1.1.6", "size"=>16384, "index"=>"95", "refcount"=>"0"},
           "com.apple.iokit.IOSerialFamily"=>
            {"version"=>"10.0.3", "size"=>40960, "index"=>"97", "refcount"=>"1"},
           "com.apple.iokit.IOSurface"=>
            {"version"=>"74.2", "size"=>49152, "index"=>"99", "refcount"=>"0"},
           "com.apple.iokit.IOThunderboltFamily"=>
            {"version"=>"1.2.2", "size"=>327680, "index"=>"100", "refcount"=>"5"},
           "com.apple.driver.AppleThunderboltNHI"=>
            {"version"=>"1.1.9", "size"=>49152, "index"=>"101", "refcount"=>"0"},
           "com.apple.iokit.IOFireWireIP"=>
            {"version"=>"2.0.3", "size"=>36864, "index"=>"102", "refcount"=>"0"},
           "com.apple.driver.AppleMCCSControl"=>
            {"version"=>"1.0.17", "size"=>32768, "index"=>"105", "refcount"=>"0"},
           "com.apple.driver.AppleUpstreamUserClient"=>
            {"version"=>"3.5.4", "size"=>20480, "index"=>"106", "refcount"=>"0"},
           "com.apple.kext.ATIFramebuffer"=>
            {"version"=>"6.3.2", "size"=>81920, "index"=>"107", "refcount"=>"0"},
           "com.apple.driver.AppleProfileCallstackAction"=>
            {"version"=>"20", "size"=>12288, "index"=>"109", "refcount"=>"0"},
           "com.apple.driver.AppleProfileKEventAction"=>
            {"version"=>"10", "size"=>8192, "index"=>"110", "refcount"=>"0"},
           "com.apple.driver.AppleProfileRegisterStateAction"=>
            {"version"=>"10", "size"=>8192, "index"=>"111", "refcount"=>"0"},
           "com.apple.driver.AudioAUUC"=>
            {"version"=>"1.54", "size"=>20480, "index"=>"112", "refcount"=>"0"},
           "com.apple.driver.AppleProfileThreadInfoAction"=>
            {"version"=>"14", "size"=>8192, "index"=>"113", "refcount"=>"0"},
           "com.apple.driver.AppleProfileTimestampAction"=>
            {"version"=>"10", "size"=>8192, "index"=>"114", "refcount"=>"0"},
           "com.apple.driver.AppleProfileReadCounterAction"=>
            {"version"=>"17", "size"=>12288, "index"=>"118", "refcount"=>"0"},
           "com.apple.driver.AppleMikeyHIDDriver"=>
            {"version"=>"1.2.0", "size"=>12288, "index"=>"120", "refcount"=>"0"},
           "com.apple.driver.AGPM"=>
            {"version"=>"100.12.31", "size"=>49152, "index"=>"121", "refcount"=>"0"},
           "com.apple.driver.AppleThunderboltPCIDownAdapter"=>
            {"version"=>"1.0.5", "size"=>12288, "index"=>"124", "refcount"=>"0"},
           "com.apple.driver.AppleThunderboltDPAdapterFamily"=>
            {"version"=>"1.1.1", "size"=>12288, "index"=>"125", "refcount"=>"2"},
           "com.apple.driver.AppleThunderboltDPInAdapter"=>
            {"version"=>"1.1.1", "size"=>12288, "index"=>"126", "refcount"=>"1"},
           "com.apple.driver.AppleThunderboltDPOutAdapter"=>
            {"version"=>"1.1.1", "size"=>32768, "index"=>"127", "refcount"=>"0"},
           "com.apple.filesystems.autofs"=>
            {"version"=>"2.1.0", "size"=>40960, "index"=>"128", "refcount"=>"0"},
           "org.virtualbox.kext.VBoxDrv"=>
            {"version"=>"4.0.4", "size"=>176128, "index"=>"129", "refcount"=>"3"},
           "org.virtualbox.kext.VBoxUSB"=>
            {"version"=>"4.0.4", "size"=>32768, "index"=>"130", "refcount"=>"0"},
           "org.virtualbox.kext.VBoxNetFlt"=>
            {"version"=>"4.0.4", "size"=>20480, "index"=>"131", "refcount"=>"0"},
           "org.virtualbox.kext.VBoxNetAdp"=>
            {"version"=>"4.0.4", "size"=>12288, "index"=>"132", "refcount"=>"0"},
           "com.apple.filesystems.afpfs"=>
            {"version"=>"9.7", "size"=>331776, "index"=>"134", "refcount"=>"0"}},
         "os"=>"Darwin"},
       "os"=>"darwin",
       "os_version"=>"10.7.3",
       "chef_packages"=>
        {"chef"=>{"version"=>"0.9.14"}, "ohai"=>{"version"=>"0.5.8"}},
       "hostname"=>"ares",
       "fqdn"=>"ares",
       "domain"=>nil,
       "network"=>
        {"interfaces"=>
          {"lo0"=>
            {"addresses"=>
              {"127.0.0.1"=>{"family"=>"inet", "netmask"=>"255.0.0.0"},
               "::1"=>{"family"=>"inet6", "prefixlen"=>"128", "scope"=>"Node"},
               "fe80::1"=>{"family"=>"inet6", "prefixlen"=>"64", "scope"=>"Link"}},
             "mtu"=>"16384",
             "flags"=>["UP", "LOOPBACK", "RUNNING", "MULTICAST"],
             "type"=>"lo",
             "number"=>"0",
             "encapsulation"=>"Loopback"},
           "gif0"=>
            {"addresses"=>{},
             "mtu"=>"1280",
             "flags"=>["POINTOPOINT", "MULTICAST"],
             "type"=>"gif",
             "number"=>"0",
             "encapsulation"=>"IPIP"},
           "stf0"=>
            {"addresses"=>{},
             "mtu"=>"1280",
             "flags"=>[],
             "type"=>"stf",
             "number"=>"0",
             "encapsulation"=>"6to4"},
           "en1"=>
            {"addresses"=>
              {"e0:f8:47:40:15:fc"=>{"family"=>"lladdr"},
               "fe80::e2f8:47ff:fe40:15fc"=>
                {"family"=>"inet6", "prefixlen"=>"64", "scope"=>"Link"},
               "10.0.1.140"=>
                {"family"=>"inet",
                 "netmask"=>"255.255.255.0",
                 "broadcast"=>"10.0.1.255"}},
             "mtu"=>"1500",
             "flags"=>
              ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"],
             "type"=>"en",
             "number"=>"1",
             "encapsulation"=>"Ethernet"},
           "fw0"=>
            {"addresses"=>{"70:cd:60:ff:fe:ee:ee:72"=>{"family"=>"lladdr"}},
             "mtu"=>"4078",
             "flags"=>
              ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"],
             "type"=>"fw",
             "number"=>"0",
             "encapsulation"=>"1394"},
           "en2"=>
            {"addresses"=>{"e0:f8:47:40:15:fd"=>{"family"=>"lladdr"}},
             "mtu"=>"1500",
             "flags"=>
              ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"],
             "type"=>"en",
             "number"=>"2",
             "encapsulation"=>"Ethernet"},
           "en0"=>
            {"addresses"=>{"c8:2a:14:06:47:42"=>{"family"=>"lladdr"}},
             "mtu"=>"1500",
             "flags"=>
              ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"],
             "type"=>"en",
             "number"=>"0",
             "encapsulation"=>"Ethernet"},
           "vboxnet0"=>
            {"addresses"=>{"0a:00:27:00:00:00"=>{"family"=>"lladdr"}},
             "mtu"=>"1500",
             "flags"=>["BROADCAST", "RUNNING", "SIMPLEX", "MULTICAST"],
             "type"=>"vboxnet",
             "number"=>"0",
             "encapsulation"=>"Ethernet"}},
         "default_interface"=>"en1",
         "settings"=>
          {"net.local.stream.sendspace"=>"8192",
           "net.local.stream.recvspace"=>"8192",
           "net.local.dgram.maxdgram"=>"2048",
           "net.local.dgram.recvspace"=>"4096",
           "net.local.inflight"=>"0",
           "net.inet.ip.portrange.lowfirst"=>"1023",
           "net.inet.ip.portrange.lowlast"=>"600",
           "net.inet.ip.portrange.first"=>"49152",
           "net.inet.ip.portrange.last"=>"65535",
           "net.inet.ip.portrange.hifirst"=>"49152",
           "net.inet.ip.portrange.hilast"=>"65535",
           "net.inet.ip.forwarding"=>"0",
           "net.inet.ip.redirect"=>"1",
           "net.inet.ip.ttl"=>"64",
           "net.inet.ip.rtexpire"=>"93",
           "net.inet.ip.rtminexpire"=>"10",
           "net.inet.ip.rtmaxcache"=>"128",
           "net.inet.ip.sourceroute"=>"0",
           "net.inet.ip.intr_queue_maxlen"=>"50",
           "net.inet.ip.intr_queue_drops"=>"0",
           "net.inet.ip.accept_sourceroute"=>"0",
           "net.inet.ip.fastforwarding"=>"0",
           "net.inet.ip.keepfaith"=>"0",
           "net.inet.ip.gifttl"=>"30",
           "net.inet.ip.subnets_are_local"=>"0",
           "net.inet.ip.check_route_selfref"=>"1",
           "net.inet.ip.use_route_genid"=>"1",
           "net.inet.ip.dummynet.hash_size"=>"64",
           "net.inet.ip.dummynet.curr_time"=>"0",
           "net.inet.ip.dummynet.ready_heap"=>"0",
           "net.inet.ip.dummynet.extract_heap"=>"0",
           "net.inet.ip.dummynet.searches"=>"0",
           "net.inet.ip.dummynet.search_steps"=>"0",
           "net.inet.ip.dummynet.expire"=>"1",
           "net.inet.ip.dummynet.max_chain_len"=>"16",
           "net.inet.ip.dummynet.red_lookup_depth"=>"256",
           "net.inet.ip.dummynet.red_avg_pkt_size"=>"512",
           "net.inet.ip.dummynet.red_max_pkt_size"=>"1500",
           "net.inet.ip.dummynet.debug"=>"0",
           "net.inet.ip.fw.enable"=>"1",
           "net.inet.ip.fw.autoinc_step"=>"100",
           "net.inet.ip.fw.one_pass"=>"0",
           "net.inet.ip.fw.debug"=>"0",
           "net.inet.ip.fw.verbose"=>"2",
           "net.inet.ip.fw.verbose_limit"=>"0",
           "net.inet.ip.fw.dyn_buckets"=>"256",
           "net.inet.ip.fw.curr_dyn_buckets"=>"256",
           "net.inet.ip.fw.dyn_count"=>"0",
           "net.inet.ip.fw.dyn_max"=>"4096",
           "net.inet.ip.fw.static_count"=>"2",
           "net.inet.ip.fw.dyn_ack_lifetime"=>"300",
           "net.inet.ip.fw.dyn_syn_lifetime"=>"20",
           "net.inet.ip.fw.dyn_fin_lifetime"=>"1",
           "net.inet.ip.fw.dyn_rst_lifetime"=>"1",
           "net.inet.ip.fw.dyn_udp_lifetime"=>"10",
           "net.inet.ip.fw.dyn_short_lifetime"=>"5",
           "net.inet.ip.fw.dyn_keepalive"=>"1",
           "net.inet.ip.maxfragpackets"=>"1536",
           "net.inet.ip.maxfragsperpacket"=>"128",
           "net.inet.ip.maxfrags"=>"3072",
           "net.inet.ip.scopedroute"=>"1",
           "net.inet.ip.check_interface"=>"0",
           "net.inet.ip.linklocal.in.allowbadttl"=>"1",
           "net.inet.ip.random_id"=>"1",
           "net.inet.ip.maxchainsent"=>"0",
           "net.inet.ip.select_srcif_debug"=>"0",
           "net.inet.icmp.maskrepl"=>"0",
           "net.inet.icmp.icmplim"=>"250",
           "net.inet.icmp.timestamp"=>"0",
           "net.inet.icmp.drop_redirect"=>"0",
           "net.inet.icmp.log_redirect"=>"0",
           "net.inet.icmp.bmcastecho"=>"1",
           "net.inet.tcp.rfc1323"=>"1",
           "net.inet.tcp.rfc1644"=>"0",
           "net.inet.tcp.mssdflt"=>"512",
           "net.inet.tcp.keepidle"=>"7200000",
           "net.inet.tcp.keepintvl"=>"75000",
           "net.inet.tcp.sendspace"=>"65536",
           "net.inet.tcp.recvspace"=>"65536",
           "net.inet.tcp.keepinit"=>"75000",
           "net.inet.tcp.v6mssdflt"=>"1024",
           "net.inet.tcp.log_in_vain"=>"3",
           "net.inet.tcp.blackhole"=>"2",
           "net.inet.tcp.delayed_ack"=>"3",
           "net.inet.tcp.tcp_lq_overflow"=>"1",
           "net.inet.tcp.drop_synfin"=>"1",
           "net.inet.tcp.reass.maxsegments"=>"3072",
           "net.inet.tcp.reass.cursegments"=>"0",
           "net.inet.tcp.reass.overflows"=>"0",
           "net.inet.tcp.slowlink_wsize"=>"8192",
           "net.inet.tcp.maxseg_unacked"=>"8",
           "net.inet.tcp.rfc3465"=>"1",
           "net.inet.tcp.rfc3465_lim2"=>"1",
           "net.inet.tcp.rexmt_thresh"=>"2",
           "net.inet.tcp.path_mtu_discovery"=>"1",
           "net.inet.tcp.slowstart_flightsize"=>"1",
           "net.inet.tcp.local_slowstart_flightsize"=>"8",
           "net.inet.tcp.newreno"=>"0",
           "net.inet.tcp.tso"=>"1",
           "net.inet.tcp.ecn_initiate_out"=>"0",
           "net.inet.tcp.ecn_negotiate_in"=>"0",
           "net.inet.tcp.packetchain"=>"50",
           "net.inet.tcp.socket_unlocked_on_output"=>"1",
           "net.inet.tcp.sack"=>"1",
           "net.inet.tcp.sack_maxholes"=>"128",
           "net.inet.tcp.sack_globalmaxholes"=>"65536",
           "net.inet.tcp.sack_globalholes"=>"0",
           "net.inet.tcp.minmss"=>"216",
           "net.inet.tcp.minmssoverload"=>"0",
           "net.inet.tcp.do_tcpdrain"=>"0",
           "net.inet.tcp.pcbcount"=>"54",
           "net.inet.tcp.icmp_may_rst"=>"1",
           "net.inet.tcp.strict_rfc1948"=>"0",
           "net.inet.tcp.isn_reseed_interval"=>"0",
           "net.inet.tcp.background_io_enabled"=>"1",
           "net.inet.tcp.rtt_min"=>"1",
           "net.inet.tcp.randomize_ports"=>"0",
           "net.inet.tcp.tcbhashsize"=>"4096",
           "net.inet.tcp.background_io_trigger"=>"5",
           "net.inet.tcp.msl"=>"15000",
           "net.inet.tcp.always_keepalive"=>"0",
           "net.inet.tcp.broken_peer_syn_rxmit_thres"=>"7",
           "net.inet.tcp.pmtud_blackhole_detection"=>"1",
           "net.inet.tcp.pmtud_blackhole_mss"=>"1200",
           "net.inet.tcp.win_scale_factor"=>"3",
           "net.inet.tcp.sockthreshold"=>"64",
           "net.inet.udp.checksum"=>"1",
           "net.inet.udp.maxdgram"=>"9216",
           "net.inet.udp.recvspace"=>"42080",
           "net.inet.udp.log_in_vain"=>"3",
           "net.inet.udp.blackhole"=>"1",
           "net.inet.udp.pcbcount"=>"72",
           "net.inet.udp.randomize_ports"=>"1",
           "net.inet.ipsec.def_policy"=>"1",
           "net.inet.ipsec.esp_trans_deflev"=>"1",
           "net.inet.ipsec.esp_net_deflev"=>"1",
           "net.inet.ipsec.ah_trans_deflev"=>"1",
           "net.inet.ipsec.ah_net_deflev"=>"1",
           "net.inet.ipsec.ah_cleartos"=>"1",
           "net.inet.ipsec.ah_offsetmask"=>"0",
           "net.inet.ipsec.dfbit"=>"0",
           "net.inet.ipsec.ecn"=>"0",
           "net.inet.ipsec.debug"=>"0",
           "net.inet.ipsec.esp_randpad"=>"-1",
           "net.inet.ipsec.bypass"=>"1",
           "net.inet.ipsec.esp_port"=>"0",
           "net.inet.raw.maxdgram"=>"8192",
           "net.inet.raw.recvspace"=>"8192",
           "net.link.generic.system.ifcount"=>"8",
           "net.link.generic.system.multi_threaded_input"=>"1",
           "net.link.generic.system.dlil_input_sanity_check"=>"0",
           "net.link.generic.system.dlil_verbose"=>"0",
           "net.link.ether.inet.prune_intvl"=>"300",
           "net.link.ether.inet.max_age"=>"1200",
           "net.link.ether.inet.host_down_time"=>"20",
           "net.link.ether.inet.apple_hwcksum_tx"=>"1",
           "net.link.ether.inet.apple_hwcksum_rx"=>"1",
           "net.link.ether.inet.maxtries"=>"5",
           "net.link.ether.inet.useloopback"=>"1",
           "net.link.ether.inet.proxyall"=>"0",
           "net.link.ether.inet.sendllconflict"=>"0",
           "net.link.ether.inet.log_arp_warnings"=>"0",
           "net.link.ether.inet.keep_announcements"=>"1",
           "net.link.ether.inet.send_conflicting_probes"=>"1",
           "net.key.debug"=>"0",
           "net.key.spi_trycnt"=>"1000",
           "net.key.spi_minval"=>"256",
           "net.key.spi_maxval"=>"268435455",
           "net.key.int_random"=>"60",
           "net.key.larval_lifetime"=>"30",
           "net.key.blockacq_count"=>"10",
           "net.key.blockacq_lifetime"=>"20",
           "net.key.esp_keymin"=>"256",
           "net.key.esp_auth"=>"0",
           "net.key.ah_keymin"=>"128",
           "net.key.prefered_oldsa"=>"0",
           "net.key.natt_keepalive_interval"=>"20",
           "net.inet6.ip6.forwarding"=>"0",
           "net.inet6.ip6.redirect"=>"1",
           "net.inet6.ip6.hlim"=>"64",
           "net.inet6.ip6.maxfragpackets"=>"1536",
           "net.inet6.ip6.accept_rtadv"=>"0",
           "net.inet6.ip6.keepfaith"=>"0",
           "net.inet6.ip6.log_interval"=>"5",
           "net.inet6.ip6.hdrnestlimit"=>"50",
           "net.inet6.ip6.dad_count"=>"1",
           "net.inet6.ip6.auto_flowlabel"=>"1",
           "net.inet6.ip6.defmcasthlim"=>"1",
           "net.inet6.ip6.gifhlim"=>"0",
           "net.inet6.ip6.kame_version"=>"20010528/apple-darwin",
           "net.inet6.ip6.use_deprecated"=>"1",
           "net.inet6.ip6.rr_prune"=>"5",
           "net.inet6.ip6.v6only"=>"0",
           "net.inet6.ip6.rtexpire"=>"3600",
           "net.inet6.ip6.rtminexpire"=>"10",
           "net.inet6.ip6.rtmaxcache"=>"128",
           "net.inet6.ip6.use_tempaddr"=>"0",
           "net.inet6.ip6.temppltime"=>"86400",
           "net.inet6.ip6.tempvltime"=>"604800",
           "net.inet6.ip6.auto_linklocal"=>"1",
           "net.inet6.ip6.maxfrags"=>"12288",
           "net.inet6.ip6.neighborgcthresh"=>"1024",
           "net.inet6.ip6.maxifprefixes"=>"16",
           "net.inet6.ip6.maxifdefrouters"=>"16",
           "net.inet6.ip6.maxdynroutes"=>"1024",
           "net.inet6.ip6.fw.enable"=>"1",
           "net.inet6.ip6.fw.debug"=>"0",
           "net.inet6.ip6.fw.verbose"=>"0",
           "net.inet6.ip6.fw.verbose_limit"=>"0",
           "net.inet6.ipsec6.def_policy"=>"1",
           "net.inet6.ipsec6.esp_trans_deflev"=>"1",
           "net.inet6.ipsec6.esp_net_deflev"=>"1",
           "net.inet6.ipsec6.ah_trans_deflev"=>"1",
           "net.inet6.ipsec6.ah_net_deflev"=>"1",
           "net.inet6.ipsec6.ecn"=>"0",
           "net.inet6.ipsec6.debug"=>"0",
           "net.inet6.ipsec6.esp_randpad"=>"-1",
           "net.inet6.icmp6.rediraccept"=>"1",
           "net.inet6.icmp6.redirtimeout"=>"600",
           "net.inet6.icmp6.nd6_prune"=>"1",
           "net.inet6.icmp6.nd6_delay"=>"5",
           "net.inet6.icmp6.nd6_umaxtries"=>"3",
           "net.inet6.icmp6.nd6_mmaxtries"=>"3",
           "net.inet6.icmp6.nd6_useloopback"=>"1",
           "net.inet6.icmp6.nodeinfo"=>"3",
           "net.inet6.icmp6.errppslimit"=>"500",
           "net.inet6.icmp6.nd6_maxnudhint"=>"0",
           "net.inet6.icmp6.nd6_debug"=>"0",
           "net.alf.loglevel"=>"55",
           "net.alf.perm"=>"1",
           "net.alf.defaultaction"=>"1",
           "net.alf.mqcount"=>"0"}},
       "counters"=>
        {"network"=>
          {"interfaces"=>
            {"lo0"=>
              {"rx"=>
                {"bytes"=>"52056550",
                 "packets"=>"36242",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"52056550",
                 "packets"=>"36242",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}},
             "gif0"=>
              {"rx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}},
             "stf0"=>
              {"rx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}},
             "en1"=>
              {"rx"=>
                {"bytes"=>"12915788662",
                 "packets"=>"19181009",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"16966829191",
                 "packets"=>"19663916",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}},
             "fw0"=>
              {"rx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"346",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}},
             "en2"=>
              {"rx"=>
                {"bytes"=>"1520741",
                 "packets"=>"2545",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"523259",
                 "packets"=>"2902",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}},
             "en0"=>
              {"rx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"342",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}},
             "vboxnet0"=>
              {"rx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "frame"=>0,
                 "compressed"=>0,
                 "multicast"=>0},
               "tx"=>
                {"bytes"=>"0",
                 "packets"=>"0",
                 "errors"=>"0",
                 "drop"=>0,
                 "overrun"=>0,
                 "collisions"=>"0",
                 "carrier"=>0,
                 "compressed"=>0}}}}},
       "ipaddress"=>"10.0.1.140",
       "macaddress"=>"e0:f8:47:40:15:fc",
       "command"=>{"ps"=>"ps -ef"},
       "dmi"=>{},
       "keys"=>
        {"ssh"=>
          {"host_dsa_public"=>
            "AAAAB3NzaC1kc3MAAACBALG94QjO9R41Ih3RRtbmbGf8y8XLG8eZAEoRxINuMpOT26C9IB1d4tFnKJm0WfDrt0lTH5OmV7Lnt82QdkzqCU5FeYbk1rqelbQIiS3aEQitMM00P9+duFk1WL5gKDOeK2EHUJEKUaPflP694YkbDtZNY/J7UmfNA007uN653ivBAAAAFQC4RmuoJFm+wJcucj0Gbg2KAUq5HQAAAIAhvRb8h/0NH6vJx1X+RehNiRWEwIj1a+ZnfpFulkzKhqb5yQXM4fuEap4dEoRLZHaxdmS0Zxar1pQjr8jGcma3aqp3ttXrNHIiPGEqlaad1/QmK0sRrE5cVEPwV4W+73xKoFk253hoBxujR8qaB8vWRLuY/g5oe6/fgBQ9pOz0JgAAAIAWBs7mMyEbzwLNMqayysNDeNqIwTSEISQVINq9l5XL4viNEvFn1bL4WNhaM927S3/UmDfQuAZXojURoYpxlXH2gycA0FOQ+CHzuSYsc5mDh9KlEb1NGvqytq3cptnIPIjcDackO+gEX9LTzyzzTJ40kZ1EH9QkgTu5pPY5/gpCGg==",
           "host_rsa_public"=>
            "AAAAB3NzaC1yc2EAAAABIwAAAQEAwp+6SsdUVnkGJE793v2+96Mfzz9QQoVja+lpG+hz+GIyO+n+q2IRPExKUis/N1iPqNV+Tc9fqPBUSu1H9kzAAIPPd7Hb+ZqU8WJX/BAfCgEK2SW53aZ2HC1vjndKUtG4RKaOlHJqsg4w0uvnbkX4yRZTtTQaJ+2UGT5TKw7Xf1QXdR3CZozcGgOJn7r0T2M7o240mr9DEn+fL/rzBXhzR86+jOBjzvvjRh6YD1IG00NGyUM0qmGPeIZxCVy16AOBmdib37USpfNv7UrLWWhdYBeALIDsRDyBKRaja337xCp3dCP7T82vLdGaBwhBlp9Mxnv/sqe+PJ2I3/sqyG88oQ=="}},
       "ohai_time"=>1303051271.765905,
       "etc"=>
        {"passwd"=>
          {"_amavisd"=>
            {"dir"=>"/var/virusmails",
             "gid"=>83,
             "uid"=>83,
             "shell"=>"/usr/bin/false",
             "gecos"=>"AMaViS Daemon"},
           "_appowner"=>
            {"dir"=>"/var/empty",
             "gid"=>87,
             "uid"=>87,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Application Owner"},
           "_appserver"=>
            {"dir"=>"/var/empty",
             "gid"=>79,
             "uid"=>79,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Application Server"},
           "_ard"=>
            {"dir"=>"/var/empty",
             "gid"=>67,
             "uid"=>67,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Apple Remote Desktop"},
           "_atsserver"=>
            {"dir"=>"/var/empty",
             "gid"=>97,
             "uid"=>97,
             "shell"=>"/usr/bin/false",
             "gecos"=>"ATS Server"},
           "_calendar"=>
            {"dir"=>"/var/empty",
             "gid"=>93,
             "uid"=>93,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Calendar"},
           "_carddav"=>
            {"dir"=>"/var/empty",
             "gid"=>206,
             "uid"=>206,
             "shell"=>"/usr/bin/false",
             "gecos"=>"CardDAV Service"},
           "_clamav"=>
            {"dir"=>"/var/virusmails",
             "gid"=>82,
             "uid"=>82,
             "shell"=>"/usr/bin/false",
             "gecos"=>"ClamAV Daemon"},
           "_coreaudiod"=>
            {"dir"=>"/var/empty",
             "gid"=>202,
             "uid"=>202,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Core Audio Daemon"},
           "_cvmsroot"=>
            {"dir"=>"/var/empty",
             "gid"=>212,
             "uid"=>212,
             "shell"=>"/usr/bin/false",
             "gecos"=>"CVMS Root"},
           "_cvs"=>
            {"dir"=>"/var/empty",
             "gid"=>72,
             "uid"=>72,
             "shell"=>"/usr/bin/false",
             "gecos"=>"CVS Server"},
           "_cyrus"=>
            {"dir"=>"/var/imap",
             "gid"=>6,
             "uid"=>77,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Cyrus Administrator"},
           "_devdocs"=>
            {"dir"=>"/var/empty",
             "gid"=>59,
             "uid"=>59,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Developer Documentation"},
           "_dovecot"=>
            {"dir"=>"/var/empty",
             "gid"=>6,
             "uid"=>214,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Dovecot Administrator"},
           "_dpaudio"=>
            {"dir"=>"/var/empty",
             "gid"=>215,
             "uid"=>215,
             "shell"=>"/usr/bin/false",
             "gecos"=>"DP Audio"},
           "_eppc"=>
            {"dir"=>"/var/empty",
             "gid"=>71,
             "uid"=>71,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Apple Events User"},
           "_installer"=>
            {"dir"=>"/var/empty",
             "gid"=>4294967294,
             "uid"=>96,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Installer"},
           "_jabber"=>
            {"dir"=>"/var/empty",
             "gid"=>84,
             "uid"=>84,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Jabber XMPP Server"},
           "_lda"=>
            {"dir"=>"/var/empty",
             "gid"=>211,
             "uid"=>211,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Local Delivery Agent"},
           "_locationd"=>
            {"dir"=>"/var/empty",
             "gid"=>205,
             "uid"=>205,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Location Daemon"},
           "_lp"=>
            {"dir"=>"/var/spool/cups",
             "gid"=>26,
             "uid"=>26,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Printing Services"},
           "_mailman"=>
            {"dir"=>"/var/empty",
             "gid"=>78,
             "uid"=>78,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Mailman List Server"},
           "_mcxalr"=>
            {"dir"=>"/var/empty",
             "gid"=>54,
             "uid"=>54,
             "shell"=>"/usr/bin/false",
             "gecos"=>"MCX AppLaunch"},
           "_mdnsresponder"=>
            {"dir"=>"/var/empty",
             "gid"=>65,
             "uid"=>65,
             "shell"=>"/usr/bin/false",
             "gecos"=>"mDNSResponder"},
           "_mysql"=>
            {"dir"=>"/var/empty",
             "gid"=>74,
             "uid"=>74,
             "shell"=>"/usr/bin/false",
             "gecos"=>"MySQL Server"},
           "_pcastagent"=>
            {"dir"=>"/var/pcast/agent",
             "gid"=>55,
             "uid"=>55,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Podcast Producer Agent"},
           "_pcastserver"=>
            {"dir"=>"/var/pcast/server",
             "gid"=>56,
             "uid"=>56,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Podcast Producer Server"},
           "_postfix"=>
            {"dir"=>"/var/spool/postfix",
             "gid"=>27,
             "uid"=>27,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Postfix Mail Server"},
           "_qtss"=>
            {"dir"=>"/var/empty",
             "gid"=>76,
             "uid"=>76,
             "shell"=>"/usr/bin/false",
             "gecos"=>"QuickTime Streaming Server"},
           "_sandbox"=>
            {"dir"=>"/var/empty",
             "gid"=>60,
             "uid"=>60,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Seatbelt"},
           "_screensaver"=>
            {"dir"=>"/var/empty",
             "gid"=>203,
             "uid"=>203,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Screensaver"},
           "_securityagent"=>
            {"dir"=>"/var/empty",
             "gid"=>92,
             "uid"=>92,
             "shell"=>"/usr/bin/false",
             "gecos"=>"SecurityAgent"},
           "_serialnumberd"=>
            {"dir"=>"/var/empty",
             "gid"=>58,
             "uid"=>58,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Serial Number Daemon"},
           "_softwareupdate"=>
            {"dir"=>"/var/empty",
             "gid"=>200,
             "uid"=>200,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Software Update Service"},
           "_spotlight"=>
            {"dir"=>"/var/empty",
             "gid"=>89,
             "uid"=>89,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Spotlight"},
           "_sshd"=>
            {"dir"=>"/var/empty",
             "gid"=>75,
             "uid"=>75,
             "shell"=>"/usr/bin/false",
             "gecos"=>"sshd Privilege separation"},
           "_svn"=>
            {"dir"=>"/var/empty",
             "gid"=>73,
             "uid"=>73,
             "shell"=>"/usr/bin/false",
             "gecos"=>"SVN Server"},
           "_teamsserver"=>
            {"dir"=>"/var/teamsserver",
             "gid"=>94,
             "uid"=>94,
             "shell"=>"/usr/bin/false",
             "gecos"=>"TeamsServer"},
           "_timezone"=>
            {"dir"=>"/var/empty",
             "gid"=>210,
             "uid"=>210,
             "shell"=>"/usr/bin/false",
             "gecos"=>"AutoTimeZoneDaemon"},
           "_tokend"=>
            {"dir"=>"/var/empty",
             "gid"=>91,
             "uid"=>91,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Token Daemon"},
           "_trustevaluationagent"=>
            {"dir"=>"/var/empty",
             "gid"=>208,
             "uid"=>208,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Trust Evaluation Agent"},
           "_unknown"=>
            {"dir"=>"/var/empty",
             "gid"=>99,
             "uid"=>99,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Unknown User"},
           "_update_sharing"=>
            {"dir"=>"/var/empty",
             "gid"=>4294967294,
             "uid"=>95,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Update Sharing"},
           "_usbmuxd"=>
            {"dir"=>"/var/db/lockdown",
             "gid"=>213,
             "uid"=>213,
             "shell"=>"/usr/bin/false",
             "gecos"=>"iPhone OS Device Helper"},
           "_uucp"=>
            {"dir"=>"/var/spool/uucp",
             "gid"=>4,
             "uid"=>4,
             "shell"=>"/usr/sbin/uucico",
             "gecos"=>"Unix to Unix Copy Protocol"},
           "_windowserver"=>
            {"dir"=>"/var/empty",
             "gid"=>88,
             "uid"=>88,
             "shell"=>"/usr/bin/false",
             "gecos"=>"WindowServer"},
           "_www"=>
            {"dir"=>"/Library/WebServer",
             "gid"=>70,
             "uid"=>70,
             "shell"=>"/usr/bin/false",
             "gecos"=>"World Wide Web Server"},
           "_xgridagent"=>
            {"dir"=>"/var/xgrid/agent",
             "gid"=>86,
             "uid"=>86,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Xgrid Agent"},
           "_xgridcontroller"=>
            {"dir"=>"/var/xgrid/controller",
             "gid"=>85,
             "uid"=>85,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Xgrid Controller"},
           "daemon"=>
            {"dir"=>"/var/root",
             "gid"=>1,
             "uid"=>1,
             "shell"=>"/usr/bin/false",
             "gecos"=>"System Services"},
           "dan"=>
            {"dir"=>"/Users/dan",
             "gid"=>20,
             "uid"=>501,
             "shell"=>"/bin/bash",
             "gecos"=>"Dan Ryan"},
           "nobody"=>
            {"dir"=>"/var/empty",
             "gid"=>4294967294,
             "uid"=>4294967294,
             "shell"=>"/usr/bin/false",
             "gecos"=>"Unprivileged User"},
           "root"=>
            {"dir"=>"/var/root",
             "gid"=>0,
             "uid"=>0,
             "shell"=>"/bin/sh",
             "gecos"=>"System Administrator"}},
         "group"=>
          {"_amavisd"=>{"gid"=>83, "members"=>[]},
           "_appowner"=>{"gid"=>87, "members"=>[]},
           "_appserveradm"=>{"gid"=>81, "members"=>[]},
           "_appserverusr"=>{"gid"=>79, "members"=>[]},
           "_ard"=>{"gid"=>67, "members"=>[]},
           "_atsserver"=>{"gid"=>97, "members"=>[]},
           "_calendar"=>{"gid"=>93, "members"=>["_teamsserver"]},
           "_carddav"=>{"gid"=>206, "members"=>[]},
           "_clamav"=>{"gid"=>82, "members"=>[]},
           "_coreaudiod"=>{"gid"=>202, "members"=>[]},
           "_cvms"=>{"gid"=>212, "members"=>[]},
           "_cvs"=>{"gid"=>72, "members"=>[]},
           "_detachedsig"=>{"gid"=>207, "members"=>["_locationd"]},
           "_devdocs"=>{"gid"=>59, "members"=>[]},
           "_developer"=>{"gid"=>204, "members"=>[]},
           "_dpaudio"=>{"gid"=>215, "members"=>[]},
           "_guest"=>{"gid"=>201, "members"=>[]},
           "_installer"=>{"gid"=>96, "members"=>[]},
           "_jabber"=>{"gid"=>84, "members"=>[]},
           "_keytabusers"=>
            {"gid"=>30, "members"=>["_calendar", "_jabber", "_postfix"]},
           "_lda"=>{"gid"=>211, "members"=>[]},
           "_locationd"=>{"gid"=>205, "members"=>[]},
           "_lp"=>{"gid"=>26, "members"=>[]},
           "_lpadmin"=>{"gid"=>98, "members"=>[]},
           "_lpoperator"=>{"gid"=>100, "members"=>[]},
           "_mailman"=>{"gid"=>78, "members"=>[]},
           "_mcxalr"=>{"gid"=>54, "members"=>[]},
           "_mdnsresponder"=>{"gid"=>65, "members"=>[]},
           "_mysql"=>{"gid"=>74, "members"=>[]},
           "_odchpass"=>{"gid"=>209, "members"=>["_teamsserver"]},
           "_pcastagent"=>{"gid"=>55, "members"=>[]},
           "_pcastserver"=>{"gid"=>56, "members"=>[]},
           "_postdrop"=>{"gid"=>28, "members"=>[]},
           "_postfix"=>{"gid"=>27, "members"=>[]},
           "_qtss"=>{"gid"=>76, "members"=>[]},
           "_sandbox"=>{"gid"=>60, "members"=>[]},
           "_screensaver"=>{"gid"=>203, "members"=>[]},
           "_securityagent"=>{"gid"=>92, "members"=>[]},
           "_serialnumberd"=>{"gid"=>58, "members"=>[]},
           "_softwareupdate"=>{"gid"=>200, "members"=>["_softwareupdate"]},
           "_spotlight"=>{"gid"=>89, "members"=>[]},
           "_sshd"=>{"gid"=>75, "members"=>[]},
           "_svn"=>{"gid"=>73, "members"=>[]},
           "_teamsserver"=>{"gid"=>94, "members"=>[]},
           "_timezone"=>{"gid"=>210, "members"=>[]},
           "_tokend"=>{"gid"=>91, "members"=>[]},
           "_trustevaluationagent"=>{"gid"=>208, "members"=>[]},
           "_unknown"=>{"gid"=>99, "members"=>[]},
           "_update_sharing"=>{"gid"=>95, "members"=>[]},
           "_usbmuxd"=>{"gid"=>213, "members"=>[]},
           "_uucp"=>{"gid"=>66, "members"=>[]},
           "_windowserver"=>{"gid"=>88, "members"=>[]},
           "_www"=>{"gid"=>70, "members"=>[]},
           "_xgridagent"=>{"gid"=>86, "members"=>[]},
           "_xgridcontroller"=>{"gid"=>85, "members"=>[]},
           "accessibility"=>{"gid"=>90, "members"=>[]},
           "admin"=>{"gid"=>80, "members"=>["root", "dan"]},
           "authedusers"=>{"gid"=>50, "members"=>[]},
           "bin"=>{"gid"=>7, "members"=>[]},
           "certusers"=>
            {"gid"=>29,
             "members"=>
              ["root", "_jabber", "_postfix", "_cyrus", "_calendar", "_dovecot"]},
           "com.apple.access_screensharing"=>{"gid"=>401, "members"=>[]},
           "consoleusers"=>{"gid"=>53, "members"=>[]},
           "daemon"=>{"gid"=>1, "members"=>["root"]},
           "dialer"=>{"gid"=>68, "members"=>[]},
           "everyone"=>{"gid"=>12, "members"=>[]},
           "group"=>{"gid"=>16, "members"=>[]},
           "interactusers"=>{"gid"=>51, "members"=>[]},
           "kmem"=>{"gid"=>2, "members"=>["root"]},
           "localaccounts"=>{"gid"=>61, "members"=>[]},
           "mail"=>{"gid"=>6, "members"=>["_teamsserver"]},
           "netaccounts"=>{"gid"=>62, "members"=>[]},
           "netusers"=>{"gid"=>52, "members"=>[]},
           "network"=>{"gid"=>69, "members"=>[]},
           "nobody"=>{"gid"=>4294967294, "members"=>[]},
           "nogroup"=>{"gid"=>4294967295, "members"=>[]},
           "operator"=>{"gid"=>5, "members"=>["root"]},
           "owner"=>{"gid"=>10, "members"=>[]},
           "procmod"=>{"gid"=>9, "members"=>["root"]},
           "procview"=>{"gid"=>8, "members"=>["root"]},
           "smmsp"=>{"gid"=>25, "members"=>[]},
           "staff"=>{"gid"=>20, "members"=>["root"]},
           "sys"=>{"gid"=>3, "members"=>["root"]},
           "tty"=>{"gid"=>4, "members"=>["root"]},
           "utmp"=>{"gid"=>45, "members"=>[]},
           "wheel"=>{"gid"=>0, "members"=>["root"]}}},
       "current_user"=>"dan",
       "platform"=>"mac_os_x",
       "platform_version"=>"10.6.7",
       "platform_build"=>"10J3250",
       "filesystem"=>
        {"/dev/disk0s2"=>
          {"block_size"=>512,
           "kb_size"=>244781464,
           "kb_used"=>78046608,
           "kb_available"=>166478856,
           "percent_used"=>"32%",
           "mount"=>"/",
           "fs_type"=>"hfs",
           "mount_options"=>["local", "journaled"]},
         "devfs"=>
          {"block_size"=>512,
           "kb_size"=>184,
           "kb_used"=>184,
           "kb_available"=>0,
           "percent_used"=>"100%",
           "mount"=>"/dev",
           "fs_type"=>"devfs",
           "mount_options"=>["local", "nobrowse"]},
         "map -hosts"=>
          {"block_size"=>512,
           "kb_size"=>0,
           "kb_used"=>0,
           "kb_available"=>0,
           "percent_used"=>"100%",
           "mount"=>"/net",
           "fs_type"=>"autofs",
           "mount_options"=>["nosuid", "automounted", "nobrowse"]},
         "map auto_home"=>
          {"block_size"=>512,
           "kb_size"=>0,
           "kb_used"=>0,
           "kb_available"=>0,
           "percent_used"=>"100%",
           "mount"=>"/home",
           "fs_type"=>"autofs",
           "mount_options"=>["automounted", "nobrowse"]}},
       "uptime_seconds"=>124383,
       "uptime"=>"1 day 10 hours 33 minutes 03 seconds",
       "load_average"=>
        {"one_minute"=>"1.10", "five_minutes"=>"1.11", "fifteen_minutes"=>"0.95"},
       "mongo"=>
        {"version"=>"1.8.0",
         "uptime"=>124361.0,
         "host"=>"ares",
         "uptime_estimate"=>81510.0,
         "databases"=>{}},
       "mysql"=>{},
       "redis"=>
        {"version"=>"2.2.2",
         "arch_bits"=>"64",
         "multiplexing_api"=>"kqueue",
         "process_id"=>"50525",
         "uptime_in_seconds"=>"124",
         "uptime_in_days"=>"0",
         "lru_clock"=>"281703",
         "used_cpu_sys"=>"0.03",
         "used_cpu_user"=>"0.02",
         "used_cpu_sys_childrens"=>"0.00",
         "used_cpu_user_childrens"=>"0.00",
         "connected_clients"=>"1",
         "connected_slaves"=>"0",
         "client_longest_output_list"=>"0",
         "client_biggest_input_buf"=>"0",
         "blocked_clients"=>"0",
         "used_memory"=>"930624",
         "used_memory_human"=>"908.81K",
         "used_memory_rss"=>"1142784",
         "mem_fragmentation_ratio"=>"1.23",
         "use_tcmalloc"=>"0",
         "loading"=>"0",
         "aof_enabled"=>"0",
         "changes_since_last_save"=>"0",
         "bgsave_in_progress"=>"0",
         "last_save_time"=>"1303051148",
         "bgrewriteaof_in_progress"=>"0",
         "total_connections_received"=>"3",
         "total_commands_processed"=>"2",
         "expired_keys"=>"0",
         "evicted_keys"=>"0",
         "keyspace_hits"=>"0",
         "keyspace_misses"=>"0",
         "hash_max_zipmap_entries"=>"512",
         "hash_max_zipmap_value"=>"64",
         "pubsub_channels"=>"0",
         "pubsub_patterns"=>"0",
         "vm_enabled"=>"0",
         "role"=>"master"
        }
      }
      10.times do
        node.snapshots << Overwatch::Snapshot.create(:raw_data => data, :node => node)
      end
    end  
  end
end