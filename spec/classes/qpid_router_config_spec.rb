require 'spec_helper'

describe 'qpid::client::config' do
  context 'on redhat' do
    let :facts do
      {
        :operatingsystem            => 'RedHat',
        :operatingsystemrelease     => '6.4',
        :operatingsystemmajrelease  => '6.4',
        :osfamily                   => 'RedHat',
        :fqdn                       => 'host.example.com',
        :processorcount             => 2,
      }
    end

    context 'without parameters' do
      let :pre_condition do
        'class {"qpid::router": }'
      end

      it 'should create configuration file' do
        content = subject.resource('file', '/etc/qpid-dispatch/qdrouterd.conf').send(:parameters)[:content]
        content.split("\n").reject { |c| c =~ /(^#|^$)/ }.should == [
          'container {',
          '    worker-threads: 2',
          '    container-name: host.example.com',
          '}',
          'router {',
          '    mode: interior',
          '    router-id: host.example.com',
          '}',
          'listener {',
          '    addr: 0.0.0.0',
          '    port: 5672',
          '    sasl-mechanisms: ANONYMOUS',
          '}',
          'fixed-address {',
          '    prefix: /closest',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /unicast',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /exclusive',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /multicast',
          '    fanout: multiple',
          '}',
          'fixed-address {',
          '    prefix: /broadcast',
          '    fanout: multiple',
          '}',
          'fixed-address {',
          '    prefix: /',
          '    fanout: multiple',
          '}'
        ]
      end
    end

    context 'on hub' do
      let :pre_condition do
        'class {"qpid::router":
           hub            => true,
           connector      => true,
           connector_addr => "1.2.3.4",
         }'
      end

      it 'should configure on-demand listener and broker connector' do
        content = subject.resource('file', '/etc/qpid-dispatch/qdrouterd.conf').send(:parameters)[:content]
        content.split("\n").reject { |c| c =~ /(^#|^$)/ }.should == [
          'container {',
          '    worker-threads: 2',
          '    container-name: host.example.com',
          '}',
          'router {',
          '    mode: interior',
          '    router-id: host.example.com',
          '}',
          'listener {',
          '    addr: 0.0.0.0',
          '    port: 9672',
          '    sasl-mechanisms: ANONYMOUS',
          '    role: inter-router',
          '}',
          'connector {',
          '    name: broker',
          '    addr: 1.2.3.4',
          '    port: 5672',
          '    sasl-mechanisms: ANONYMOUS',
          '    role: on-demand',
          '}',
          'listener {',
          '    addr: 0.0.0.0',
          '    port: 5672',
          '    sasl-mechanisms: ANONYMOUS',
          '}',
          'fixed-address {',
          '    prefix: /closest',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /unicast',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /exclusive',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /multicast',
          '    fanout: multiple',
          '}',
          'fixed-address {',
          '    prefix: /broadcast',
          '    fanout: multiple',
          '}',
          'fixed-address {',
          '    prefix: /',
          '    fanout: multiple',
          '}'
        ]
      end
    end

    context 'on hub client' do
      let :pre_condition do
        'class {"qpid::router":
           connector       => true,
           connector_name  => "hub",
           connector_role  => "inter-router",
           connector_addr  => "1.2.3.4",
           connector_port  => "9672",
         }'
      end

      it 'should configure connector to hub' do
        content = subject.resource('file', '/etc/qpid-dispatch/qdrouterd.conf').send(:parameters)[:content]
        content.split("\n").reject { |c| c =~ /(^#|^$)/ }.should == [
          'container {',
          '    worker-threads: 2',
          '    container-name: host.example.com',
          '}',
          'router {',
          '    mode: interior',
          '    router-id: host.example.com',
          '}',
          'connector {',
          '    name: hub',
          '    addr: 1.2.3.4',
          '    port: 9672',
          '    sasl-mechanisms: ANONYMOUS',
          '    role: inter-router',
          '}',
          'listener {',
          '    addr: 0.0.0.0',
          '    port: 5672',
          '    sasl-mechanisms: ANONYMOUS',
          '}',
          'fixed-address {',
          '    prefix: /closest',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /unicast',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /exclusive',
          '    fanout: single',
          '    bias: closest',
          '}',
          'fixed-address {',
          '    prefix: /multicast',
          '    fanout: multiple',
          '}',
          'fixed-address {',
          '    prefix: /broadcast',
          '    fanout: multiple',
          '}',
          'fixed-address {',
          '    prefix: /',
          '    fanout: multiple',
          '}'
        ]
      end
    end
  end
end
