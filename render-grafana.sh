#!/usr/bin/env bash

export GRAFANA_HOST="https://play.grafana.org"
export DASHBOARD_NAME="graph-styles"
# export API_KEY="eyJrIjoibGF2bG1Gb2tkbGY2YTd1cVJVVUVGdmU4am1ybTB5SnEiLCJuIjoidGVzdCIsImlkIjoxfQ=="

panels_id=([3]=Bars [7]=CPU [17]=Request)

# Grafana uses a weird timestamp values with timestamp + 000
# still don't know what those 3 zeros mean
START_TIMESTAMP="1596643200000"
END_TIMESTAMP="1596646800000"

function get_render_chart(){
    DOWNLOAD_URL="${GRAFANA_HOST}/render/dashboard-solo/db/$DASHBOARD_NAME?panelId=${3}&from=${1}&to=${2}&width=1000&height=500"
    
    # This can be made on Grafana dashboards using auth if you send the API key on the header
    # curl -o graph_renders/"${4}"".png -H "Authorization: Bearer $API_KEY" "$DOWNLOAD_URL"
    curl -o graph_renders/"${4}".png "$DOWNLOAD_URL"
}

mkdir -p graph_renders
for panel_id in "${!panels_id[@]}"
do
    get_render_chart "$START_TIMESTAMP" "$END_TIMESTAMP" "$panel_id" "${panels_id[$panel_id]}"
done
