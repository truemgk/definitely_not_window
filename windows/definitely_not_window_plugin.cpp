// This must be included before many other Windows headers.
#include <windows.h>

#include "./include/definitely_not_window/definitely_not_window_plugin.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>
#include <sstream>

#include "api.h"

const char kChannelName[] = "definitely_not/window";
const auto dnAPI = dn_window_api();

std::unique_ptr<flutter::MethodChannel<>> dn_window_channel;

namespace
{

    class DefinitelyNotWindowPlugin : public flutter::Plugin
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        DefinitelyNotWindowPlugin(
            flutter::PluginRegistrarWindows *registrar,
            std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>> channel);

        virtual ~DefinitelyNotWindowPlugin();

    private:
        // Called when a method is called on this plugin's channel from Dart.
        void HandleMethodCall(
            const flutter::MethodCall<flutter::EncodableValue> &method_call,
            std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

        // The registrar for this plugin.
        flutter::PluginRegistrarWindows *registrar_;

        // The cannel to send menu item activations on.
        std::unique_ptr<flutter::MethodChannel<>> channel_;
    };

    // static
    void DefinitelyNotWindowPlugin::RegisterWithRegistrar(
        flutter::PluginRegistrarWindows *registrar)
    {
        auto channel =
            std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
                registrar->messenger(), kChannelName,
                &flutter::StandardMethodCodec::GetInstance());

        auto *channel_pointer = channel.get();

        auto plugin = std::make_unique<DefinitelyNotWindowPlugin>(registrar, std::move(channel));

        channel_pointer->SetMethodCallHandler(
            [plugin_pointer = plugin.get()](const auto &call, auto result)
            {
                plugin_pointer->HandleMethodCall(call, std::move(result));
            });

        registrar->AddPlugin(std::move(plugin));
    }

    DefinitelyNotWindowPlugin::DefinitelyNotWindowPlugin(
        flutter::PluginRegistrarWindows *registrar,
        std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>> channel) : registrar_(registrar), channel_(std::move(channel))
    {
    }

    DefinitelyNotWindowPlugin::~DefinitelyNotWindowPlugin()
    {
    }

    void DefinitelyNotWindowPlugin::HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
    {
        if (method_call.method_name().compare("dragWindow") == 0)
        {
            bool callResult = dnAPI->privateAPI->dragWindow();
            if (callResult)
            {
                result->Success();
            }
            else
            {
                result->Error("ERROR_DRAG_WINDOW_FAILED", "Could not drag app window");
            }
        }
        else
        {
            result->NotImplemented();
        }
    }

} // namespace

void DefinitelyNotWindowPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
    DefinitelyNotWindowPlugin::RegisterWithRegistrar(
        flutter::PluginRegistrarManager::GetInstance()
            ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
