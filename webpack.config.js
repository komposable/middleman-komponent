var webpack = require("webpack");

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
        use: [
          "style-loader",
          { loader: "css-loader", options: { importLoaders: 1 } },
          "postcss-loader"
        ]
      }
    ]
  }
};
