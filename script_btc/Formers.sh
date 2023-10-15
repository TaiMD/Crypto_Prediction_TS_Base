
if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/btc/testing" ]; then
    mkdir ./logs/btc/testing
fi


for embed_type in  3 4 1 2
    do
    for model_name in Informer Transformer
        do
        for seq_len in 6
            do
            for batch_size in 32
                do
                for pred_len in 3 5 7
                    do
                    python -u run_longExp.py \
                        --is_training 1 \
                        --root_path ./dataset/ \
                        --data_path btc_1h_6f.csv \
                        --model_id BTC_$seq_len'_'$pred_len \
                        --model $model_name \
                        --data custom \
                        --features MS \
                        --seq_len $seq_len \
                        --pred_len $pred_len \
                        --enc_in 5 \
                        --dec_in 5 \
                        --des 'Exp' \
                        --target close \
                        --label_len 2 \
                        --factor 1 \
                        --c_out 5 \
                        --itr 1 \
                        --embed_type $embed_type \
                        --moving_avg $pred_len \
                        --batch_size $batch_size \
                        --e_layers 2 \
                        --d_layers 1 \
                        --d_ff 2048 \
                        --n_heads 12 \
                        --train_epochs 30 >logs/btc/Informer/$model_name'_'$embed_type'_b'$batch_size'_seq'$seq_len'_pred'$pred_len'_'$d_ff.log
                done
            done
        done
    done
done

