// Copyright 2025 Bytedance Ltd. and/or its affiliates
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#pragma once

#include <string>
#include <vector>
#include <memory>
#include <stdexcept>
#include <regex>
#include <cstring>
#include <xxhash.h>
#include <grpcpp/grpcpp.h>
#include "rollout-cache.grpc.pb.h"

using namespace specrl_fix;

class SuffixCacheUpdater {
public:
    SuffixCacheUpdater();
    explicit SuffixCacheUpdater(const std::vector<std::string>& server_addresses);
    ~SuffixCacheUpdater();

    // Update cache with multiple prompts and their corresponding responses
    void update_response_cache(
        const std::vector<std::vector<int>>& prompts,
        const std::vector<std::vector<int>>& responses,
        const std::vector<float>& prompt_lengths,
        const std::vector<float>& response_lengths,
        int responses_per_prompt);

    // 新增的update_prompt_cache函数声明
    void update_prompt_cache(
        const std::vector<std::vector<int>>& prompts,
        const std::vector<float>& prompt_lengths);

private:
    std::vector<std::string> server_addresses_;
    std::vector<std::unique_ptr<specrl_fix::RolloutCacheService::Stub>> stubs_;

    // Helper to extract server addresses from environment
    std::vector<std::string> extract_addresses_from_env();

    // Helper to initialize gRPC stubs
    void initialize_stubs();
};
