
# if [ ! -d "./logs" ]; then
#     mkdir ./logs
# fi

# if [ ! -d "./logs/btc" ]; then
#     mkdir ./logs/btc
# fi

# batch_size=16


# for model_name in NLinear # Linear DLinear 
# do
#   for seq_len in 192 316 528 720
#   do 
#     for pred_len in 3 5 7
#     do 
#       python -u run_longExp.py \
#         --is_training 1 \
#         --root_path ./dataset/ \
#         --data_path btc.csv \
#         --model_id BTC \
#         --model $model_name \
#         --data custom \
#         --feature S \
#         --seq_len $seq_len \
#         --pred_len $pred_len \
#         --enc_in 1 \
#         --dec_in 1 \
#         --des 'Exp' \
#         --target close \
#         --learning_rate 0.0001 \
#         --batch_size $batch_size \
#         --c_out 1 \
#         --train_epochs 20 \
#         --do_predict \
#         --itr 1  >logs/btc/Linears/$model_name'_'BTC_batch$batch_size'_seq'$seq_len'_pred'$pred_len.log 
#     done
#   done
# done


if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/btc/Linears_hourly_MS_54f" ]; then
    mkdir ./logs/btc/Linears_hourly_MS_54f
fi

batch_size=16

for model_name in DLinear NLinear Linear 
do
  for seq_len in 48 72 96 192 336 # hours
  do
    for pred_len in 1 5 7 # hours
    do 
      python -u run_longExp.py \
        --is_training 1 \
        --root_path ./dataset/ \
        --data_path btc_1h_54f.csv \
        --model_id BTC_$seq_len'_'$pred_len \
        --model $model_name \
        --data custom \
        --feature MS \
        --seq_len $seq_len \
        --pred_len $pred_len \
        --label_len 48 \
        --enc_in 53 \
        --dec_in 53 \
        --des 'Exp' \
        --target close \
        --learning_rate 0.0001 \
        --batch_size $batch_size \
        --train_epochs 20 \
        --moving_avg 1 \
        --do_predict \
        --itr 1  >logs/btc/Linears_hourly_MS_54f/$model_name'_'BTC_batch$batch_size'_seq'$seq_len'_pred'$pred_len.log 
    done
  done
done
