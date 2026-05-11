#!/bin/bash
# =============================================================
#  Audio Translate Input 本地一键测试报告生成器
#  用法: bash scripts/generate_test_report.sh
# =============================================================

set -e

REPORT_FILE="test_report_$(date +%Y%m%d_%H%M%S).md"
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FLUTTER_DIR="$PROJECT_ROOT/app_demo"
EDGE_FN_DIR="$PROJECT_ROOT/supabase/functions/audio-process"

echo "🧪 Audio Translate Input 自动化测试报告生成器"
echo "================================"
echo ""

# 初始化报告
cat > "$REPORT_FILE" << 'EOF'
# 🧪 Audio Translate Input 测试报告

EOF

echo "**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# ========== Flutter 测试 ==========
echo "📱 运行 Flutter 测试..."
echo "## 📱 Flutter 单元测试" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

cd "$FLUTTER_DIR"
FLUTTER_RESULT=0
flutter test --reporter expanded 2>&1 | tee /tmp/flutter_test_output.txt || FLUTTER_RESULT=$?

echo '```' >> "$PROJECT_ROOT/$REPORT_FILE"
cat /tmp/flutter_test_output.txt >> "$PROJECT_ROOT/$REPORT_FILE"
echo '```' >> "$PROJECT_ROOT/$REPORT_FILE"
echo "" >> "$PROJECT_ROOT/$REPORT_FILE"

if [ $FLUTTER_RESULT -eq 0 ]; then
  echo "**结果: ✅ 全部通过**" >> "$PROJECT_ROOT/$REPORT_FILE"
else
  echo "**结果: ❌ 存在失败**" >> "$PROJECT_ROOT/$REPORT_FILE"
fi

echo "" >> "$PROJECT_ROOT/$REPORT_FILE"
echo "---" >> "$PROJECT_ROOT/$REPORT_FILE"
echo "" >> "$PROJECT_ROOT/$REPORT_FILE"

cd "$PROJECT_ROOT"

# ========== API 测试（可选） ==========
echo "" >> "$REPORT_FILE"
echo "## 🌐 Edge Function API 测试" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

if command -v deno &> /dev/null; then
  read -p "🔑 是否运行 API 测试？(会调用真实 API 产生少量费用) [y/N]: " RUN_API
  if [[ "$RUN_API" =~ ^[Yy]$ ]]; then
    echo "🌐 运行 Edge Function API 测试..."
    API_RESULT=0
    deno test --allow-net --allow-env "$EDGE_FN_DIR/api_tests.ts" 2>&1 | tee /tmp/api_test_output.txt || API_RESULT=$?

    echo '```' >> "$REPORT_FILE"
    cat /tmp/api_test_output.txt >> "$REPORT_FILE"
    echo '```' >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    if [ $API_RESULT -eq 0 ]; then
      echo "**结果: ✅ 全部通过**" >> "$REPORT_FILE"
    else
      echo "**结果: ❌ 存在失败**" >> "$REPORT_FILE"
    fi
  else
    echo "_已跳过（用户选择不运行）_" >> "$REPORT_FILE"
  fi
else
  echo "_已跳过（未安装 Deno）_" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# ========== 总结 ==========
echo "## 📊 总结" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "| 测试层 | 状态 |" >> "$REPORT_FILE"
echo "|-------|------|" >> "$REPORT_FILE"

if [ $FLUTTER_RESULT -eq 0 ]; then
  echo "| Flutter 单元测试 | ✅ 通过 |" >> "$REPORT_FILE"
else
  echo "| Flutter 单元测试 | ❌ 失败 |" >> "$REPORT_FILE"
fi

if [[ "$RUN_API" =~ ^[Yy]$ ]]; then
  if [ ${API_RESULT:-1} -eq 0 ]; then
    echo "| Edge Function API 测试 | ✅ 通过 |" >> "$REPORT_FILE"
  else
    echo "| Edge Function API 测试 | ❌ 失败 |" >> "$REPORT_FILE"
  fi
else
  echo "| Edge Function API 测试 | ⏭️ 已跳过 |" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

echo ""
echo "================================"
echo "✅ 测试报告已生成: $REPORT_FILE"
echo ""
