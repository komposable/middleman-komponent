var webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  entry: {
    site: "./source/index.js"
  },
  resolve: {
    alias: {
      components: __dirname + "/source/components"
    }
  },
  output: {
    path: __dirname + "/.tmp/dist",
    filename: "javascripts/[name].js"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /(node_modules)/,
        use: ["babel-loader"]
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: [
            { loader: "css-loader", options: { importLoaders: 1 } },
            "postcss-loader"
          ]
        })
      }
    ]
  },
  plugins: [new ExtractTextPlugin(__dirname + "/source/stylesheets/site.css")]
};
