# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.provider :virtualbox do |v, override|
        v.customize ["modifyvm", :id, "--memory", 2048]
        v.customize ["modifyvm", :id, "--cpus", 1]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
        v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    end

    ["vmware_fusion", "vmware_workstation"].each do |provider|
      config.vm.provider provider do |v, override|
        v.vmx["memsize"] = "2048"
        v.vmx["numvcpus"] = "1"
        v.vmx["cpuid.coresPerSocket"] = "1"
        v.vmx["ethernet0.virtualDev"] = "vmxnet3"
      end
    end
end
