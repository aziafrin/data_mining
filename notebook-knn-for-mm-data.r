{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "76fb0a48",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:02.854752Z",
     "iopub.status.busy": "2022-05-07T07:30:02.852828Z",
     "iopub.status.idle": "2022-05-07T07:30:04.143746Z",
     "shell.execute_reply": "2022-05-07T07:30:04.142058Z"
    },
    "papermill": {
     "duration": 1.298532,
     "end_time": "2022-05-07T07:30:04.145910",
     "exception": false,
     "start_time": "2022-05-07T07:30:02.847378",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.1 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.5     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.6     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.8\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.0     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.1\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'mymensingh'"
      ],
      "text/latex": [
       "'mymensingh'"
      ],
      "text/markdown": [
       "'mymensingh'"
      ],
      "text/plain": [
       "[1] \"mymensingh\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "eedce460",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.182724Z",
     "iopub.status.busy": "2022-05-07T07:30:04.153991Z",
     "iopub.status.idle": "2022-05-07T07:30:04.221022Z",
     "shell.execute_reply": "2022-05-07T07:30:04.219313Z"
    },
    "papermill": {
     "duration": 0.073837,
     "end_time": "2022-05-07T07:30:04.223376",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.149539",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "###K nearest neighbor(knn) clustering algorithm for mymensingh data\n",
    "##required package\n",
    "library(class)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "9b8d1198",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.232695Z",
     "iopub.status.busy": "2022-05-07T07:30:04.231281Z",
     "iopub.status.idle": "2022-05-07T07:30:04.280983Z",
     "shell.execute_reply": "2022-05-07T07:30:04.279352Z"
    },
    "papermill": {
     "duration": 0.056706,
     "end_time": "2022-05-07T07:30:04.283104",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.226398",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>ID</th><th scope=col>Station</th><th scope=col>Year</th><th scope=col>Month</th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>T_RAN</th><th scope=col>A_RAIN</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1</td><td>Mymensingh</td><td>1960</td><td>1</td><td>16.9</td><td>11.3</td><td>2.0</td><td>73.39</td><td>1016.0</td><td> 15</td><td> 0.48</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2</td><td>Mymensingh</td><td>1960</td><td>2</td><td>21.4</td><td>12.6</td><td>1.7</td><td>66.34</td><td>1013.0</td><td>  0</td><td> 0.00</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>3</td><td>Mymensingh</td><td>1960</td><td>3</td><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td> 69</td><td> 2.23</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4</td><td>Mymensingh</td><td>1960</td><td>4</td><td>29.9</td><td>17.6</td><td>2.2</td><td>59.03</td><td>1007.1</td><td> 27</td><td> 0.90</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>5</td><td>Mymensingh</td><td>1960</td><td>5</td><td>29.6</td><td>23.2</td><td>2.4</td><td>73.45</td><td>1003.4</td><td>187</td><td> 6.03</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>6</td><td>Mymensingh</td><td>1960</td><td>6</td><td>28.2</td><td>24.1</td><td>2.0</td><td>84.03</td><td>1001.6</td><td>363</td><td>12.10</td><td>MHR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & ID & Station & Year & Month & TEM & DPT & WIS & HUM & SLP & T\\_RAN & A\\_RAIN & RAN\\\\\n",
       "  & <int> & <chr> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1 & Mymensingh & 1960 & 1 & 16.9 & 11.3 & 2.0 & 73.39 & 1016.0 &  15 &  0.48 & NRT\\\\\n",
       "\t2 & 2 & Mymensingh & 1960 & 2 & 21.4 & 12.6 & 1.7 & 66.34 & 1013.0 &   0 &  0.00 & NRT\\\\\n",
       "\t3 & 3 & Mymensingh & 1960 & 3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 &  69 &  2.23 & LTR\\\\\n",
       "\t4 & 4 & Mymensingh & 1960 & 4 & 29.9 & 17.6 & 2.2 & 59.03 & 1007.1 &  27 &  0.90 & NRT\\\\\n",
       "\t5 & 5 & Mymensingh & 1960 & 5 & 29.6 & 23.2 & 2.4 & 73.45 & 1003.4 & 187 &  6.03 & LTR\\\\\n",
       "\t6 & 6 & Mymensingh & 1960 & 6 & 28.2 & 24.1 & 2.0 & 84.03 & 1001.6 & 363 & 12.10 & MHR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 12\n",
       "\n",
       "| <!--/--> | ID &lt;int&gt; | Station &lt;chr&gt; | Year &lt;int&gt; | Month &lt;int&gt; | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | T_RAN &lt;int&gt; | A_RAIN &lt;dbl&gt; | RAN &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1 | Mymensingh | 1960 | 1 | 16.9 | 11.3 | 2.0 | 73.39 | 1016.0 |  15 |  0.48 | NRT |\n",
       "| 2 | 2 | Mymensingh | 1960 | 2 | 21.4 | 12.6 | 1.7 | 66.34 | 1013.0 |   0 |  0.00 | NRT |\n",
       "| 3 | 3 | Mymensingh | 1960 | 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 |  69 |  2.23 | LTR |\n",
       "| 4 | 4 | Mymensingh | 1960 | 4 | 29.9 | 17.6 | 2.2 | 59.03 | 1007.1 |  27 |  0.90 | NRT |\n",
       "| 5 | 5 | Mymensingh | 1960 | 5 | 29.6 | 23.2 | 2.4 | 73.45 | 1003.4 | 187 |  6.03 | LTR |\n",
       "| 6 | 6 | Mymensingh | 1960 | 6 | 28.2 | 24.1 | 2.0 | 84.03 | 1001.6 | 363 | 12.10 | MHR |\n",
       "\n"
      ],
      "text/plain": [
       "  ID Station    Year Month TEM  DPT  WIS HUM   SLP    T_RAN A_RAIN RAN\n",
       "1 1  Mymensingh 1960 1     16.9 11.3 2.0 73.39 1016.0  15    0.48  NRT\n",
       "2 2  Mymensingh 1960 2     21.4 12.6 1.7 66.34 1013.0   0    0.00  NRT\n",
       "3 3  Mymensingh 1960 3     24.1 14.9 2.3 64.13 1011.4  69    2.23  LTR\n",
       "4 4  Mymensingh 1960 4     29.9 17.6 2.2 59.03 1007.1  27    0.90  NRT\n",
       "5 5  Mymensingh 1960 5     29.6 23.2 2.4 73.45 1003.4 187    6.03  LTR\n",
       "6 6  Mymensingh 1960 6     28.2 24.1 2.0 84.03 1001.6 363   12.10  MHR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#load the dataset\n",
    "x1<-read.csv(\"../input/mymensingh/Mymensingh.csv\",header=T)\n",
    "head(x1)  #to see the first 6 row of the data\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "2d61abaa",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.292687Z",
     "iopub.status.busy": "2022-05-07T07:30:04.291245Z",
     "iopub.status.idle": "2022-05-07T07:30:04.324102Z",
     "shell.execute_reply": "2022-05-07T07:30:04.322530Z"
    },
    "papermill": {
     "duration": 0.039691,
     "end_time": "2022-05-07T07:30:04.326144",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.286453",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>672</li><li>12</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 672\n",
       "\\item 12\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 672\n",
       "2. 12\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 672  12"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "69"
      ],
      "text/latex": [
       "69"
      ],
      "text/markdown": [
       "69"
      ],
      "text/plain": [
       "[1] 69"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>654</li><li>12</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 654\n",
       "\\item 12\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 654\n",
       "2. 12\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 654  12"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(x1)             ##check the dimension of the data\n",
    "sum(is.na(x1))      ##check the pressence of missing value\n",
    "xx<-na.omit(x1)     ##omit the missing values if there any\n",
    "dim(xx)             #check the dimension again after dropping the missing values\n",
    "sum(is.na(xx))      #final check of missing values"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "a20fd63a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.336172Z",
     "iopub.status.busy": "2022-05-07T07:30:04.334730Z",
     "iopub.status.idle": "2022-05-07T07:30:04.360063Z",
     "shell.execute_reply": "2022-05-07T07:30:04.358475Z"
    },
    "papermill": {
     "duration": 0.045375,
     "end_time": "2022-05-07T07:30:04.375141",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.329766",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>16.9</td><td>11.3</td><td>2.0</td><td>73.39</td><td>1016.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>21.4</td><td>12.6</td><td>1.7</td><td>66.34</td><td>1013.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>29.9</td><td>17.6</td><td>2.2</td><td>59.03</td><td>1007.1</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>29.6</td><td>23.2</td><td>2.4</td><td>73.45</td><td>1003.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>28.2</td><td>24.1</td><td>2.0</td><td>84.03</td><td>1001.6</td><td>MHR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & TEM & DPT & WIS & HUM & SLP & RAN\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 16.9 & 11.3 & 2.0 & 73.39 & 1016.0 & NRT\\\\\n",
       "\t2 & 21.4 & 12.6 & 1.7 & 66.34 & 1013.0 & NRT\\\\\n",
       "\t3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 & LTR\\\\\n",
       "\t4 & 29.9 & 17.6 & 2.2 & 59.03 & 1007.1 & NRT\\\\\n",
       "\t5 & 29.6 & 23.2 & 2.4 & 73.45 & 1003.4 & LTR\\\\\n",
       "\t6 & 28.2 & 24.1 & 2.0 & 84.03 & 1001.6 & MHR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | RAN &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 1 | 16.9 | 11.3 | 2.0 | 73.39 | 1016.0 | NRT |\n",
       "| 2 | 21.4 | 12.6 | 1.7 | 66.34 | 1013.0 | NRT |\n",
       "| 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 | LTR |\n",
       "| 4 | 29.9 | 17.6 | 2.2 | 59.03 | 1007.1 | NRT |\n",
       "| 5 | 29.6 | 23.2 | 2.4 | 73.45 | 1003.4 | LTR |\n",
       "| 6 | 28.2 | 24.1 | 2.0 | 84.03 | 1001.6 | MHR |\n",
       "\n"
      ],
      "text/plain": [
       "  TEM  DPT  WIS HUM   SLP    RAN\n",
       "1 16.9 11.3 2.0 73.39 1016.0 NRT\n",
       "2 21.4 12.6 1.7 66.34 1013.0 NRT\n",
       "3 24.1 14.9 2.3 64.13 1011.4 LTR\n",
       "4 29.9 17.6 2.2 59.03 1007.1 NRT\n",
       "5 29.6 23.2 2.4 73.45 1003.4 LTR\n",
       "6 28.2 24.1 2.0 84.03 1001.6 MHR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "xx[,c(1:4,10,11)]=NULL      ##selecting the required column from the data\n",
    "head(xx)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "ff9b588d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.386109Z",
     "iopub.status.busy": "2022-05-07T07:30:04.384707Z",
     "iopub.status.idle": "2022-05-07T07:30:04.404784Z",
     "shell.execute_reply": "2022-05-07T07:30:04.403049Z"
    },
    "papermill": {
     "duration": 0.02805,
     "end_time": "2022-05-07T07:30:04.407088",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.379038",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "##splitting the data into train dataset and test dataset\n",
    "set.seed(17701055)\n",
    "ID=sample(1:nrow(xx),round(nrow(xx)*0.75,0),F)    \n",
    "TR<-xx[ID,]      ##training data\n",
    "TS<-xx[-ID,]      ##test dat\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "ac477db0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.417634Z",
     "iopub.status.busy": "2022-05-07T07:30:04.416145Z",
     "iopub.status.idle": "2022-05-07T07:30:04.484755Z",
     "shell.execute_reply": "2022-05-07T07:30:04.483014Z"
    },
    "papermill": {
     "duration": 0.076744,
     "end_time": "2022-05-07T07:30:04.487621",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.410877",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "E=numeric(0)\n",
    "A=numeric(0)\n",
    "I=numeric(0)\n",
    "for(i in 2:20){\n",
    "KK<-knn(train=TR[,-6],test=TS[,-6],cl=TR[,6],k=i)\n",
    "    T<-table(TS[,6],KK)\n",
    "I[i-1]=i\n",
    "A[i-1]=sum(diag(T))/sum(T)   ##accuracy rate\n",
    "E[i-1]=1-sum(diag(T))/sum(T)  ##error rate\n",
    " }"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "93f730fe",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.500326Z",
     "iopub.status.busy": "2022-05-07T07:30:04.498754Z",
     "iopub.status.idle": "2022-05-07T07:30:04.541670Z",
     "shell.execute_reply": "2022-05-07T07:30:04.539882Z"
    },
    "papermill": {
     "duration": 0.050874,
     "end_time": "2022-05-07T07:30:04.543903",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.493029",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>0.646341463414634</li><li>0.713414634146341</li><li>0.707317073170732</li><li>0.695121951219512</li><li>0.701219512195122</li><li>0.707317073170732</li><li>0.713414634146341</li><li>0.719512195121951</li><li>0.725609756097561</li><li>0.707317073170732</li><li>0.707317073170732</li><li>0.707317073170732</li><li>0.719512195121951</li><li>0.713414634146341</li><li>0.713414634146341</li><li>0.713414634146341</li><li>0.731707317073171</li><li>0.731707317073171</li><li>0.73780487804878</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 0.646341463414634\n",
       "\\item 0.713414634146341\n",
       "\\item 0.707317073170732\n",
       "\\item 0.695121951219512\n",
       "\\item 0.701219512195122\n",
       "\\item 0.707317073170732\n",
       "\\item 0.713414634146341\n",
       "\\item 0.719512195121951\n",
       "\\item 0.725609756097561\n",
       "\\item 0.707317073170732\n",
       "\\item 0.707317073170732\n",
       "\\item 0.707317073170732\n",
       "\\item 0.719512195121951\n",
       "\\item 0.713414634146341\n",
       "\\item 0.713414634146341\n",
       "\\item 0.713414634146341\n",
       "\\item 0.731707317073171\n",
       "\\item 0.731707317073171\n",
       "\\item 0.73780487804878\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 0.646341463414634\n",
       "2. 0.713414634146341\n",
       "3. 0.707317073170732\n",
       "4. 0.695121951219512\n",
       "5. 0.701219512195122\n",
       "6. 0.707317073170732\n",
       "7. 0.713414634146341\n",
       "8. 0.719512195121951\n",
       "9. 0.725609756097561\n",
       "10. 0.707317073170732\n",
       "11. 0.707317073170732\n",
       "12. 0.707317073170732\n",
       "13. 0.719512195121951\n",
       "14. 0.713414634146341\n",
       "15. 0.713414634146341\n",
       "16. 0.713414634146341\n",
       "17. 0.731707317073171\n",
       "18. 0.731707317073171\n",
       "19. 0.73780487804878\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] 0.6463415 0.7134146 0.7073171 0.6951220 0.7012195 0.7073171 0.7134146\n",
       " [8] 0.7195122 0.7256098 0.7073171 0.7073171 0.7073171 0.7195122 0.7134146\n",
       "[15] 0.7134146 0.7134146 0.7317073 0.7317073 0.7378049"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>0.353658536585366</li><li>0.286585365853659</li><li>0.292682926829268</li><li>0.304878048780488</li><li>0.298780487804878</li><li>0.292682926829268</li><li>0.286585365853659</li><li>0.280487804878049</li><li>0.274390243902439</li><li>0.292682926829268</li><li>0.292682926829268</li><li>0.292682926829268</li><li>0.280487804878049</li><li>0.286585365853659</li><li>0.286585365853659</li><li>0.286585365853659</li><li>0.268292682926829</li><li>0.268292682926829</li><li>0.26219512195122</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 0.353658536585366\n",
       "\\item 0.286585365853659\n",
       "\\item 0.292682926829268\n",
       "\\item 0.304878048780488\n",
       "\\item 0.298780487804878\n",
       "\\item 0.292682926829268\n",
       "\\item 0.286585365853659\n",
       "\\item 0.280487804878049\n",
       "\\item 0.274390243902439\n",
       "\\item 0.292682926829268\n",
       "\\item 0.292682926829268\n",
       "\\item 0.292682926829268\n",
       "\\item 0.280487804878049\n",
       "\\item 0.286585365853659\n",
       "\\item 0.286585365853659\n",
       "\\item 0.286585365853659\n",
       "\\item 0.268292682926829\n",
       "\\item 0.268292682926829\n",
       "\\item 0.26219512195122\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 0.353658536585366\n",
       "2. 0.286585365853659\n",
       "3. 0.292682926829268\n",
       "4. 0.304878048780488\n",
       "5. 0.298780487804878\n",
       "6. 0.292682926829268\n",
       "7. 0.286585365853659\n",
       "8. 0.280487804878049\n",
       "9. 0.274390243902439\n",
       "10. 0.292682926829268\n",
       "11. 0.292682926829268\n",
       "12. 0.292682926829268\n",
       "13. 0.280487804878049\n",
       "14. 0.286585365853659\n",
       "15. 0.286585365853659\n",
       "16. 0.286585365853659\n",
       "17. 0.268292682926829\n",
       "18. 0.268292682926829\n",
       "19. 0.26219512195122\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] 0.3536585 0.2865854 0.2926829 0.3048780 0.2987805 0.2926829 0.2865854\n",
       " [8] 0.2804878 0.2743902 0.2926829 0.2926829 0.2926829 0.2804878 0.2865854\n",
       "[15] 0.2865854 0.2865854 0.2682927 0.2682927 0.2621951"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li><li>11</li><li>12</li><li>13</li><li>14</li><li>15</li><li>16</li><li>17</li><li>18</li><li>19</li><li>20</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 2\n",
       "\\item 3\n",
       "\\item 4\n",
       "\\item 5\n",
       "\\item 6\n",
       "\\item 7\n",
       "\\item 8\n",
       "\\item 9\n",
       "\\item 10\n",
       "\\item 11\n",
       "\\item 12\n",
       "\\item 13\n",
       "\\item 14\n",
       "\\item 15\n",
       "\\item 16\n",
       "\\item 17\n",
       "\\item 18\n",
       "\\item 19\n",
       "\\item 20\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 2\n",
       "2. 3\n",
       "3. 4\n",
       "4. 5\n",
       "5. 6\n",
       "6. 7\n",
       "7. 8\n",
       "8. 9\n",
       "9. 10\n",
       "10. 11\n",
       "11. 12\n",
       "12. 13\n",
       "13. 14\n",
       "14. 15\n",
       "15. 16\n",
       "16. 17\n",
       "17. 18\n",
       "18. 19\n",
       "19. 20\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 19 × 3 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>I</th><th scope=col>A</th><th scope=col>E</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td> 2</td><td>0.6463415</td><td>0.3536585</td></tr>\n",
       "\t<tr><td> 3</td><td>0.7134146</td><td>0.2865854</td></tr>\n",
       "\t<tr><td> 4</td><td>0.7073171</td><td>0.2926829</td></tr>\n",
       "\t<tr><td> 5</td><td>0.6951220</td><td>0.3048780</td></tr>\n",
       "\t<tr><td> 6</td><td>0.7012195</td><td>0.2987805</td></tr>\n",
       "\t<tr><td> 7</td><td>0.7073171</td><td>0.2926829</td></tr>\n",
       "\t<tr><td> 8</td><td>0.7134146</td><td>0.2865854</td></tr>\n",
       "\t<tr><td> 9</td><td>0.7195122</td><td>0.2804878</td></tr>\n",
       "\t<tr><td>10</td><td>0.7256098</td><td>0.2743902</td></tr>\n",
       "\t<tr><td>11</td><td>0.7073171</td><td>0.2926829</td></tr>\n",
       "\t<tr><td>12</td><td>0.7073171</td><td>0.2926829</td></tr>\n",
       "\t<tr><td>13</td><td>0.7073171</td><td>0.2926829</td></tr>\n",
       "\t<tr><td>14</td><td>0.7195122</td><td>0.2804878</td></tr>\n",
       "\t<tr><td>15</td><td>0.7134146</td><td>0.2865854</td></tr>\n",
       "\t<tr><td>16</td><td>0.7134146</td><td>0.2865854</td></tr>\n",
       "\t<tr><td>17</td><td>0.7134146</td><td>0.2865854</td></tr>\n",
       "\t<tr><td>18</td><td>0.7317073</td><td>0.2682927</td></tr>\n",
       "\t<tr><td>19</td><td>0.7317073</td><td>0.2682927</td></tr>\n",
       "\t<tr><td>20</td><td>0.7378049</td><td>0.2621951</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 19 × 3 of type dbl\n",
       "\\begin{tabular}{lll}\n",
       " I & A & E\\\\\n",
       "\\hline\n",
       "\t  2 & 0.6463415 & 0.3536585\\\\\n",
       "\t  3 & 0.7134146 & 0.2865854\\\\\n",
       "\t  4 & 0.7073171 & 0.2926829\\\\\n",
       "\t  5 & 0.6951220 & 0.3048780\\\\\n",
       "\t  6 & 0.7012195 & 0.2987805\\\\\n",
       "\t  7 & 0.7073171 & 0.2926829\\\\\n",
       "\t  8 & 0.7134146 & 0.2865854\\\\\n",
       "\t  9 & 0.7195122 & 0.2804878\\\\\n",
       "\t 10 & 0.7256098 & 0.2743902\\\\\n",
       "\t 11 & 0.7073171 & 0.2926829\\\\\n",
       "\t 12 & 0.7073171 & 0.2926829\\\\\n",
       "\t 13 & 0.7073171 & 0.2926829\\\\\n",
       "\t 14 & 0.7195122 & 0.2804878\\\\\n",
       "\t 15 & 0.7134146 & 0.2865854\\\\\n",
       "\t 16 & 0.7134146 & 0.2865854\\\\\n",
       "\t 17 & 0.7134146 & 0.2865854\\\\\n",
       "\t 18 & 0.7317073 & 0.2682927\\\\\n",
       "\t 19 & 0.7317073 & 0.2682927\\\\\n",
       "\t 20 & 0.7378049 & 0.2621951\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 19 × 3 of type dbl\n",
       "\n",
       "| I | A | E |\n",
       "|---|---|---|\n",
       "|  2 | 0.6463415 | 0.3536585 |\n",
       "|  3 | 0.7134146 | 0.2865854 |\n",
       "|  4 | 0.7073171 | 0.2926829 |\n",
       "|  5 | 0.6951220 | 0.3048780 |\n",
       "|  6 | 0.7012195 | 0.2987805 |\n",
       "|  7 | 0.7073171 | 0.2926829 |\n",
       "|  8 | 0.7134146 | 0.2865854 |\n",
       "|  9 | 0.7195122 | 0.2804878 |\n",
       "| 10 | 0.7256098 | 0.2743902 |\n",
       "| 11 | 0.7073171 | 0.2926829 |\n",
       "| 12 | 0.7073171 | 0.2926829 |\n",
       "| 13 | 0.7073171 | 0.2926829 |\n",
       "| 14 | 0.7195122 | 0.2804878 |\n",
       "| 15 | 0.7134146 | 0.2865854 |\n",
       "| 16 | 0.7134146 | 0.2865854 |\n",
       "| 17 | 0.7134146 | 0.2865854 |\n",
       "| 18 | 0.7317073 | 0.2682927 |\n",
       "| 19 | 0.7317073 | 0.2682927 |\n",
       "| 20 | 0.7378049 | 0.2621951 |\n",
       "\n"
      ],
      "text/plain": [
       "      I  A         E        \n",
       " [1,]  2 0.6463415 0.3536585\n",
       " [2,]  3 0.7134146 0.2865854\n",
       " [3,]  4 0.7073171 0.2926829\n",
       " [4,]  5 0.6951220 0.3048780\n",
       " [5,]  6 0.7012195 0.2987805\n",
       " [6,]  7 0.7073171 0.2926829\n",
       " [7,]  8 0.7134146 0.2865854\n",
       " [8,]  9 0.7195122 0.2804878\n",
       " [9,] 10 0.7256098 0.2743902\n",
       "[10,] 11 0.7073171 0.2926829\n",
       "[11,] 12 0.7073171 0.2926829\n",
       "[12,] 13 0.7073171 0.2926829\n",
       "[13,] 14 0.7195122 0.2804878\n",
       "[14,] 15 0.7134146 0.2865854\n",
       "[15,] 16 0.7134146 0.2865854\n",
       "[16,] 17 0.7134146 0.2865854\n",
       "[17,] 18 0.7317073 0.2682927\n",
       "[18,] 19 0.7317073 0.2682927\n",
       "[19,] 20 0.7378049 0.2621951"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "A\n",
    "E\n",
    "I\n",
    "cbind(I,A,E)    #accuracy rate and error rate for different values of I\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "44e70f59",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.556282Z",
     "iopub.status.busy": "2022-05-07T07:30:04.554786Z",
     "iopub.status.idle": "2022-05-07T07:30:04.818035Z",
     "shell.execute_reply": "2022-05-07T07:30:04.816397Z"
    },
    "papermill": {
     "duration": 0.271624,
     "end_time": "2022-05-07T07:30:04.820023",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.548399",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "19"
      ],
      "text/latex": [
       "19"
      ],
      "text/markdown": [
       "19"
      ],
      "text/plain": [
       "[1] 19"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "which(min(E)==E)\n",
    "plot(2:20,E,\"l\",lwd=2,main=\"Error rate for different values of I\")\n",
    "abline(h=min(E),lty=2,lwd=2)\n",
    "abline(v=10,lty=2,lwd=2)\n",
    "points(10,min(E),pch=21,cex=3,col=\"red\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "5d4f66b1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.833446Z",
     "iopub.status.busy": "2022-05-07T07:30:04.832030Z",
     "iopub.status.idle": "2022-05-07T07:30:04.850428Z",
     "shell.execute_reply": "2022-05-07T07:30:04.848693Z"
    },
    "papermill": {
     "duration": 0.027363,
     "end_time": "2022-05-07T07:30:04.852717",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.825354",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "K1<-knn(train=TR[,-6],test=TS[,-6],cl=TR[,6],k=10)\n",
    "\n",
    "TTM<-table(TS[,6],K1)\n",
    "\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "225112cd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.866522Z",
     "iopub.status.busy": "2022-05-07T07:30:04.864953Z",
     "iopub.status.idle": "2022-05-07T07:30:04.883304Z",
     "shell.execute_reply": "2022-05-07T07:30:04.881691Z"
    },
    "papermill": {
     "duration": 0.027793,
     "end_time": "2022-05-07T07:30:04.885759",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.857966",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.713414634146341"
      ],
      "text/latex": [
       "0.713414634146341"
      ],
      "text/markdown": [
       "0.713414634146341"
      ],
      "text/plain": [
       "[1] 0.7134146"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "A1<-sum(diag(TTM))/sum(TTM)\n",
    "A1\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ab29e2c7",
   "metadata": {
    "papermill": {
     "duration": 0.005446,
     "end_time": "2022-05-07T07:30:04.896553",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.891107",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Accuracy rate is 0.7073 that is 70.73%."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "12aa7ef4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:30:04.909882Z",
     "iopub.status.busy": "2022-05-07T07:30:04.908439Z",
     "iopub.status.idle": "2022-05-07T07:30:04.927665Z",
     "shell.execute_reply": "2022-05-07T07:30:04.925915Z"
    },
    "papermill": {
     "duration": 0.028139,
     "end_time": "2022-05-07T07:30:04.929904",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.901765",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.286585365853659"
      ],
      "text/latex": [
       "0.286585365853659"
      ],
      "text/markdown": [
       "0.286585365853659"
      ],
      "text/plain": [
       "[1] 0.2865854"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "E1<-1-A1\n",
    "E1"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b3aa5efa",
   "metadata": {
    "papermill": {
     "duration": 0.005323,
     "end_time": "2022-05-07T07:30:04.940717",
     "exception": false,
     "start_time": "2022-05-07T07:30:04.935394",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Th error rate 0.292 that is 29.2%\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 5.614479,
   "end_time": "2022-05-07T07:30:05.070756",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-05-07T07:29:59.456277",
   "version": "2.3.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
