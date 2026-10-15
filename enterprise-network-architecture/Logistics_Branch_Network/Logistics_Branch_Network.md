# Logistics Branch Network Architecture Simulation

## Project Overview
This project simulates a secure and scalable network architecture for a logistics branch office using Cisco Packet Tracer. The objective is to logically separate network traffic between the warehouse systems and the administrative office, utilizing a "Router-on-a-Stick" configuration for Inter-VLAN routing and automated IP allocation via DHCP.

## Technologies & Protocols Used
* **Routing & Switching:** Cisco IOS (1941 Router, 2960 Switches)
* **VLANs & 802.1Q Trunking:** Logical network segmentation
* **Inter-VLAN Routing:** Router-on-a-stick topology
* **DHCP:** Automated IP addressing for end devices

## Network Topology & IP Allocation

| VLAN ID | Department | Network Address | Default Gateway (Router Sub-interface) |
| :--- | :--- | :--- | :--- |
| 10 | Warehouse (Scanners, Servers) | 192.168.10.0/24 | 192.168.10.1 |
| 20 | Office (Administration PCs) | 192.168.20.0/24 | 192.168.20.1 |

---

## Configuration Steps (CLI Commands)

The following configurations were applied to establish the network infrastructure.

### 1. Trunk Links Configuration
To allow multiple VLANs to pass between the switches and the router, standard 802.1Q trunk links were established.

**On Switch0 (Upper Switch connected to Router):**
```text
enable
configure terminal
interface fastEthernet 0/1
switchport mode trunk
exit
interface fastEthernet 0/4
switchport mode trunk
exit
On Switch1 (Lower Switch connected to Switch0):
enable
configure terminal
interface fastEthernet 0/1
switchport mode trunk
exit
2. Inter-VLAN Routing (Router-on-a-Stick)
The physical router interface was activated, and sub-interfaces were created and assigned to their respective VLANs to handle routing between the isolated networks.

On Router0:
enable
configure terminal
interface gigabitEthernet 0/1
no shutdown
exit

interface gigabitEthernet 0/1.10
encapsulation dot1Q 10
ip address 192.168.10.1 255.255.255.0
exit

interface gigabitEthernet 0/1.20
encapsulation dot1Q 20
ip address 192.168.20.1 255.255.255.0
exit
3. VLAN Creation & Access Ports
VLANs were defined on both switches, and switchports were explicitly assigned to their corresponding VLANs to connect end devices.

On Switch0 (Office & partial Warehouse):
enable
configure terminal
vlan 10
name Warehouse
vlan 20
name Office
exit

! Assigning Office PCs to VLAN 20
interface range fastEthernet 0/2-3
switchport mode access
switchport access vlan 20
exit

! Assigning the Warehouse Server to VLAN 10
interface fastEthernet 0/5
switchport mode access
switchport access vlan 10
exit
On Switch1 (Warehouse):

Plaintext
enable
configure terminal
vlan 10
name Warehouse
vlan 20
name Office
exit

! Assigning Warehouse PCs to VLAN 10
interface range fastEthernet 0/2-3
switchport mode access
switchport access vlan 10
exit
4. DHCP Server Setup
To automate IP addressing for the growing number of logistics devices, the router was configured as a DHCP server with separate pools for each VLAN.

On Router0:
enable
configure terminal

! Exclude gateways from the DHCP pool
ip dhcp excluded-address 192.168.10.1
ip dhcp excluded-address 192.168.20.1

! Pool for Warehouse (VLAN 10)
ip dhcp pool Warehouse-Pool
network 192.168.10.0 255.255.255.0
default-router 192.168.10.1
dns-server 8.8.8.8
exit

! Pool for Office (VLAN 20)
ip dhcp pool Office-Pool
network 192.168.20.0 255.255.255.0
default-router 192.168.20.1
dns-server 8.8.8.8
exit
```
## Verification
### The network was successfully tested by:

#### Verifying that PCs in both the Office and Warehouse departments dynamically received the correct IP addresses via DHCP.

#### Sending ICMP ping requests between the Office PC (192.168.20.X) and the Warehouse Server (192.168.10.X), confirming successful Inter-VLAN routing functionality.

<img width="1263" height="771" alt="image" src="https://github.com/user-attachments/assets/e2df398f-edfc-4813-8208-2d8782637739" />
<img width="910" height="760" alt="image" src="https://github.com/user-attachments/assets/adc6b278-0646-4574-bf1d-57eb61a0fe9f" />
<img width="910" height="760" alt="image" src="https://github.com/user-attachments/assets/f98c65da-bbd5-4250-8357-acea046ac95d" />

