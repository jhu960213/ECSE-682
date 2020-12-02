################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer.c \
/Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.c \
/Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.c \
/Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.c 

OBJS += \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer.o \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.o \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.o \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.o 

C_DEPS += \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer.d \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.d \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.d \
./gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.d 


# Each subdirectory must supply rules for building sources it contributes
gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer.o: /Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DMBEDTLS_CONFIG_FILE=<mbedtls_config.h>' '-DEFR32BG22C224F512IM40=1' -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/config" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/toolchain/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/nvm3/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/device_init/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/mpu/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emlib/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/system/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//protocol/bluetooth/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/src/cryptoacc/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/power_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/common" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ble" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ieee802154" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/zwave" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/crypto/sl_component/se_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/silicon_labs/silabs_core/memory_manager" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/configs" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader/api" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//app/bluetooth/common/app_assert" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/CMSIS/Include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/sleeptimer/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/Device/SiliconLabs/EFR32BG22/Include" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/autogen" -Os -Wall -Wextra -fno-builtin -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer.d" -MT"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer.o" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.o: /Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DMBEDTLS_CONFIG_FILE=<mbedtls_config.h>' '-DEFR32BG22C224F512IM40=1' -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/config" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/toolchain/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/nvm3/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/device_init/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/mpu/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emlib/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/system/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//protocol/bluetooth/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/src/cryptoacc/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/power_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/common" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ble" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ieee802154" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/zwave" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/crypto/sl_component/se_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/silicon_labs/silabs_core/memory_manager" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/configs" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader/api" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//app/bluetooth/common/app_assert" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/CMSIS/Include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/sleeptimer/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/Device/SiliconLabs/EFR32BG22/Include" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/autogen" -Os -Wall -Wextra -fno-builtin -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.d" -MT"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.o" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.o: /Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DMBEDTLS_CONFIG_FILE=<mbedtls_config.h>' '-DEFR32BG22C224F512IM40=1' -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/config" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/toolchain/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/nvm3/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/device_init/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/mpu/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emlib/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/system/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//protocol/bluetooth/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/src/cryptoacc/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/power_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/common" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ble" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ieee802154" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/zwave" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/crypto/sl_component/se_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/silicon_labs/silabs_core/memory_manager" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/configs" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader/api" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//app/bluetooth/common/app_assert" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/CMSIS/Include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/sleeptimer/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/Device/SiliconLabs/EFR32BG22/Include" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/autogen" -Os -Wall -Wextra -fno-builtin -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.d" -MT"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.o" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.o: /Applications/Simplicity\ Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DMBEDTLS_CONFIG_FILE=<mbedtls_config.h>' '-DEFR32BG22C224F512IM40=1' -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/config" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/toolchain/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/nvm3/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/device_init/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/mpu/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emlib/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/system/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//protocol/bluetooth/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/src/cryptoacc/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/sl_crypto/include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/emdrv/common/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/power_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/common" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ble" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/ieee802154" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/protocol/zwave" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/crypto/sl_component/se_manager/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/silicon_labs/silabs_core/memory_manager" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//util/third_party/mbedtls/configs" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/bootloader/api" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//app/bluetooth/common/app_assert" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/CMSIS/Include" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/service/sleeptimer/inc" -I"/Applications/Simplicity Studio.app/Contents/Eclipse/developer/sdks/gecko_sdk_suite/v3.0//platform/Device/SiliconLabs/EFR32BG22/Include" -I"/Users/jhu69/SimplicityStudio/v5_workspace/soc_ibeacon/autogen" -Os -Wall -Wextra -fno-builtin -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.d" -MT"gecko_sdk_3.0.0/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.o" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


