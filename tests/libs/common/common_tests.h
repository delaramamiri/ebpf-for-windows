// Copyright (c) Microsoft Corporation
// SPDX-License-Identifier: MIT
#pragma once

/**
 * @file
 * @brief Common test functions used by end to end and component tests.
 */

#include "bpf/bpf.h"
#include "bpf/libbpf.h"
#include "ebpf_api.h"
#include "ebpf_result.h"
#include "socket_helper.h"

#include <windows.h>
#include <future>
#include <set>

#define RING_BUFFER_TEST_EVENT_COUNT 10

typedef enum _user_type
{
    ADMINISTRATOR,
    STANDARD_USER
} user_type_t;

typedef struct _test_addresses
{
    struct sockaddr_storage loopback_address;
    struct sockaddr_storage remote_address;
    struct sockaddr_storage local_address;
    struct sockaddr_storage vip_address;
} test_addresses_t;
typedef struct _close_bpf_object
{
    void
    operator()(_In_opt_ _Post_invalid_ bpf_object* object)
    {
        if (object != nullptr) {
            bpf_object__close(object);
        }
    }
} close_bpf_object_t;
typedef std::unique_ptr<bpf_object, close_bpf_object_t> bpf_object_ptr;

typedef struct _test_globals
{
    user_type_t user_type = STANDARD_USER;
    HANDLE user_token = nullptr;
    ADDRESS_FAMILY family = 0;
    IPPROTO protocol = IPPROTO_IPV4;
    uint16_t destination_port = 4444;
    uint16_t proxy_port = 4443;
    test_addresses_t addresses[socket_family_t::Max] = {0};
    bool attach_v4_program = false;
    bool attach_v6_program = false;
    bpf_object_ptr bpf_object;
} test_globals_t;
void
ebpf_test_pinned_map_enum();
void
verify_utility_helper_results(_In_ const bpf_object* object, bool helper_override);

typedef struct _ring_buffer_test_event_context
{
    _ring_buffer_test_event_context();
    ~_ring_buffer_test_event_context();
    void
    unsubscribe();
    std::promise<void> ring_buffer_event_promise;
    struct ring_buffer* ring_buffer;
    const std::vector<std::vector<char>>* records;
    std::set<size_t> event_received;
    bool canceled;
    int matched_entry_count;
    int test_event_count;
} ring_buffer_test_event_context_t;

int
ring_buffer_test_event_handler(_Inout_ void* ctx, _In_opt_ const void* data, size_t size);

void
ring_buffer_api_test_helper(
    fd_t ring_buffer_map, std::vector<std::vector<char>>& expected_records, std::function<void(int)> generate_event);
