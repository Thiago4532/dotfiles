#include <xmm/print.hpp>
#include <xmm/socket.hpp>
#include <unordered_map>
#include <map>

int main() {
    std::unordered_map<std::uint16_t, std::pair<std::size_t, std::string>> clients;
    std::map<std::size_t, std::uint16_t> orders;

    xmm::SocketAddress address("xmobar");
    xmm::Socket socket;
    socket.bind(address);

    xmm::XmmMessage message;
    std::size_t orderId = 0;

    xmm::println();
    while(message.recv(socket)) {
        auto clientId = message.client_id();
        if (auto it = clients.find(clientId); it == clients.end()) {
            if (message.isexit()) continue;
            clients.emplace(clientId, std::make_pair(orderId, message.data()));
            orders[orderId] = message.client_id();
            ++orderId;
        } else {
            if (message.isexit()) {
                orders.erase(it->second.first);
                clients.erase(it);
            } else {
                it->second.second = message.data();
                for (auto& c : it->second.second) {
                    if (c == '\n') c = '@';
                }
                orders[it->second.first] = message.client_id();
            }
        }

        bool first = true;
        for (const auto& [order, id] : orders) {
            auto& data = clients[id].second;
            if (!data.empty()) {
                xmm::print(data);
            }
            xmm::print("  |  ");
        }
        xmm::println();
    }
    return 0;
}
