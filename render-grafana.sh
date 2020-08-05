#!/usr/bin/env bash

# Dashboard URL: https://play.grafana.org/d/000000012/grafana-play-home?orgId=1
# Render ULR: http://monitor.k8s.eigen.live/grafana/render/dashboard-solo/db/kubernetes-compute-resources-cluster?panelId=7
# https://play.grafana.org/render/dashboard-solo/db/graph-styles?panelId=3&fullscreen&from=1439016566245&to=1439020166246&width=1000&height=500

export GRAFANA_HOST="https://play.grafana.org"
export START_TIMESTAMP="1596643200000"
export END_TIMESTAMP="1596646800000"
export DASHBOARD_NAME="graph-styles"

panels_id=([3]=Bars [7]=CPU [17]=Request)

function get_render_chart(){
    DOWNLOAD_URL="${GRAFANA_HOST}/render/dashboard-solo/db/$DASHBOARD_NAME?panelId=${3}&from=${1}&to=${2}&width=1000&height=500"
    curl $DOWNLOAD_URL > graph_renders/${4}.png
}

mkdir -p graph_renders
for panel_id in "${!panels_id[@]}"
do
    get_render_chart "$START_TIMESTAMP" "$END_TIMESTAMP" "$panel_id" "${panels_id[$panel_id]}"
done
