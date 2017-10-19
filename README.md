# bLDA(budget Latent Dirichlet Allocation)

# ファイル
## bLDA.stan
  * bLDAのstanファイル
## run-model-bLDA.R	
  * bLDAの実行ファイル
## sim-model-bLDA.R
  * bLDAのシミュレーションデータの生成ファイル
# シミュレーションデータ詳細
  * ドキュメント数 50
  * 単語数 100
  * トピック数 6
  * ドキュメント毎の単語数 round(exponential(rnorm(6.0,0.5))
  * ベータ分布のパラメータ
    * alpha,beta = [(2,5),(2,5),(2,5),(5,2),(5,2),(5,2)]
  
  
 ＊ 詳しくはsim-model-bLDA.Rを参照
