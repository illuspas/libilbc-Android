LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= libilbc

LOCAL_C_INCLUDES := $(LOCAL_PATH) 		\
	$(LOCAL_PATH)/ilbc 					\
	$(LOCAL_PATH)/ilbc/interface 		\
	$(LOCAL_PATH)/signal_processing 	\
	$(LOCAL_PATH)/signal_processing/include 

LOCAL_SRC_FILES := ilbc/abs_quant.c                                          \
	ilbc/abs_quant_loop.c                                                    \
	ilbc/augmented_cb_corr.c                                                 \
	ilbc/bw_expand.c                                                         \
	ilbc/cb_construct.c                                                      \
	ilbc/cb_mem_energy.c                                                     \
	ilbc/cb_mem_energy_augmentation.c                                        \
	ilbc/cb_mem_energy_calc.c                                                \
	ilbc/cb_search.c                                                         \
	ilbc/cb_search_core.c                                                    \
	ilbc/cb_update_best_index.c                                              \
	ilbc/chebyshev.c                                                         \
	ilbc/comp_corr.c                                                         \
	ilbc/constants.c                                                         \
	ilbc/create_augmented_vec.c                                              \
	ilbc/decode.c                                                            \
	ilbc/decode_residual.c                                                   \
	ilbc/decoder_interpolate_lsf.c                                           \
	ilbc/do_plc.c                                                            \
	ilbc/encode.c                                                            \
	ilbc/energy_inverse.c                                                    \
	ilbc/enh_upsample.c                                                      \
	ilbc/enhancer.c                                                          \
	ilbc/enhancer_interface.c                                                \
	ilbc/filtered_cb_vecs.c                                                  \
	ilbc/frame_classify.c                                                    \
	ilbc/gain_dequant.c                                                      \
	ilbc/gain_quant.c                                                        \
	ilbc/get_cd_vec.c                                                        \
	ilbc/get_lsp_poly.c                                                      \
	ilbc/get_sync_seq.c                                                      \
	ilbc/hp_input.c                                                          \
	ilbc/hp_output.c                                                         \
	ilbc/ilbc.c                                                              \
	ilbc/index_conv_dec.c                                                    \
	ilbc/index_conv_enc.c                                                    \
	ilbc/init_decode.c                                                       \
	ilbc/init_encode.c                                                       \
	ilbc/interpolate.c                                                       \
	ilbc/interpolate_samples.c                                               \
	ilbc/lpc_encode.c                                                        \
	ilbc/lsf_check.c                                                         \
	ilbc/lsf_interpolate_to_poly_dec.c                                       \
	ilbc/lsf_interpolate_to_poly_enc.c                                       \
	ilbc/lsf_to_lsp.c                                                        \
	ilbc/lsf_to_poly.c                                                       \
	ilbc/lsp_to_lsf.c                                                        \
	ilbc/my_corr.c                                                           \
	ilbc/nearest_neighbor.c                                                  \
	ilbc/pack_bits.c                                                         \
	ilbc/poly_to_lsf.c                                                       \
	ilbc/poly_to_lsp.c                                                       \
	ilbc/refiner.c                                                           \
	ilbc/simple_interpolate_lsf.c                                            \
	ilbc/simple_lpc_analysis.c                                               \
	ilbc/simple_lsf_dequant.c                                                \
	ilbc/simple_lsf_quant.c                                                  \
	ilbc/smooth.c                                                            \
	ilbc/smooth_out_data.c                                                   \
	ilbc/sort_sq.c                                                           \
	ilbc/split_vq.c                                                          \
	ilbc/state_construct.c                                                   \
	ilbc/state_search.c                                                      \
	ilbc/swap_bytes.c                                                        \
	ilbc/unpack_bits.c                                                       \
	ilbc/vq3.c                                                               \
	ilbc/vq4.c                                                               \
	ilbc/window32_w32.c                                                      \
	ilbc/xcorr_coef.c                                                        \
	signal_processing/auto_corr_to_refl_coef.c                                \
	signal_processing/auto_correlation.c                                      \
	signal_processing/complex_bit_reverse_arm.S                               \
	signal_processing/complex_fft.c                                           \
	signal_processing/copy_set_operations.c                                   \
	signal_processing/cross_correlation.c                                     \
	signal_processing/division_operations.c                                   \
	signal_processing/dot_product_with_scale.c                                \
	signal_processing/downsample_fast.c                                       \
	signal_processing/energy.c                                                \
	signal_processing/filter_ar.c                                             \
	signal_processing/filter_ma_fast_q12.c                                    \
	signal_processing/get_hanning_window.c                                    \
	signal_processing/get_scaling_square.c                                    \
	signal_processing/ilbc_specific_functions.c                               \
	signal_processing/levinson_durbin.c                                       \
	signal_processing/lpc_to_refl_coef.c                                      \
	signal_processing/min_max_operations.c                                    \
	signal_processing/randomization_functions.c                               \
	signal_processing/real_fft.c                                              \
	signal_processing/refl_coef_to_lpc.c                                      \
	signal_processing/resample.c                                              \
	signal_processing/resample_48khz.c                                        \
	signal_processing/resample_by_2.c                                         \
	signal_processing/resample_by_2_internal.c                                \
	signal_processing/resample_fractional.c                                   \
	signal_processing/spl_init.c                                              \
	signal_processing/spl_sqrt.c                                              \
	signal_processing/spl_sqrt_floor_arm.S                                    \
	signal_processing/splitting_filter.c                                      \
	signal_processing/sqrt_of_one_minus_x_squared.c                           \
	signal_processing/vector_scaling_operations.c                             \



LOCAL_CFLAGS := -O2 -DWEBRTC_POSIX

ifeq ($(TARGET_ARCH_ABI),armeabi)
    LOCAL_CFLAGS += -mfpu=vfp -mfloat-abi=softfp
	LOCAL_SRC_FILES += signal_processing/filter_ar_fast_q12.c                                    	
endif

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp -mvectorize-with-neon-quad -DWEBRTC_ARCH_ARM_NEON -DWEBRTC_ARCH_ARM_V7
    LOCAL_LDFLAGS := -Wl,--fix-cortex-a8
	LOCAL_SRC_FILES += 	\
	signal_processing/cross_correlation_neon.S                                \
	signal_processing/downsample_fast_neon.S                                  \
	signal_processing/filter_ar_fast_q12_armv7.S                              \
	signal_processing/min_max_operations_neon.S                               \
	signal_processing/vector_scaling_operations_neon.S
endif


include $(BUILD_SHARED_LIBRARY)
